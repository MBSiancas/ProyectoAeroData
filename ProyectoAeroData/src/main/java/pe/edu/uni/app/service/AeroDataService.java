package pe.edu.uni.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import pe.edu.uni.app.dto.MantenimientoDTO;
import pe.edu.uni.app.dto.PasajeroDTO;
import pe.edu.uni.app.dto.ReservaDTO;

@Service
public class AeroDataService {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public List<Map<String, Object>> getVuelos() {
		String sql = "select *from VUELO";
		List<Map<String, Object>> listado;
		listado = jdbcTemplate.queryForList(sql);
		return listado;
	}

	@Transactional(propagation = Propagation.REQUIRES_NEW, rollbackFor = Exception.class)
	public PasajeroDTO crearPasajero(PasajeroDTO bean) {
		// Variables
		String sql, id_pasajero;
		int cont;
		// Verificar el numero de pasaporte (si ya existe, entonces ya fue p, tendria
		// que hacer reserva)
		// Creando su id
		sql = "select top 1 id_pasajero from PASAJERO order by id_pasajero desc";
		cont = jdbcTemplate.queryForObject(sql, Integer.class);
		cont += 1;
		id_pasajero = "000000" + cont;
		id_pasajero = id_pasajero.substring(id_pasajero.length() - 6);

		// Registrar Pasajero
		sql = "insert into PASAJERO ";
		sql += "(id_pasajero, nombre, num_pasaporte, nacionalidad,";
		sql += "num_vuelos, email, telefono) ";
		sql += "values (?,?,?,?,0,?,?)";
		Object[] datos = { id_pasajero, bean.getNombre(), bean.getNum_pasaporte(), bean.getNacionalidad(),
				bean.getEmail(), bean.getTelefono() };
		jdbcTemplate.update(sql, datos);
		// Reporte
		bean.setId_pasajero(id_pasajero);
		bean.setNum_vuelos(0);
		return bean;
	}

	@Transactional(propagation = Propagation.REQUIRES_NEW, rollbackFor = Exception.class)
	public ReservaDTO crearReserva(ReservaDTO bean) {
		// Variables
		String sql, estado=null, id_reserva;
		double pagoReserva, costoVuelo;
		int cont, numActPasajeros, numMaxPasajeros;
		// Verificar que exista el vuelo
		sql = "select count(1) cont from VUELO where id_vuelo = ?";
		cont = jdbcTemplate.queryForObject(sql, Integer.class, bean.getId_vuelo());
		if (cont != 1) {
			throw new RuntimeException("El vuelo no existe");
		}
		// Verificar el numero de pasaporte (si no existe, fue p, tendria que pasar al
		// service de crearPasajero)
		sql = "select count(1) cont from PASAJERO where id_pasajero = ?";
		cont = jdbcTemplate.queryForObject(sql, Integer.class, bean.getId_pasajero());
		if (cont != 1) {
			throw new RuntimeException("El pasajero no está registrado");
		}
		// Verificar pago de la reserva
		pagoReserva = bean.getPago();
		sql = "select precio from VUELO where id_vuelo = ?";
		costoVuelo = jdbcTemplate.queryForObject(sql, Double.class, bean.getId_vuelo());
		if (pagoReserva < costoVuelo && pagoReserva>=0) {
			estado = "Pendiente";
		} else if (pagoReserva == costoVuelo) {
			estado = "Confirmado";
		} else {
			throw new RuntimeException("El monto pagado no es adecuado");
		}
		// Verificar si hay espacio en el vuelo
		sql = "select num_max_pasajeros from VUELO where id_vuelo = ?";
		numMaxPasajeros = jdbcTemplate.queryForObject(sql, Integer.class, bean.getId_vuelo());
		sql = "select num_actu_pasajeros from VUELO where id_vuelo = ?";
		numActPasajeros = jdbcTemplate.queryForObject(sql, Integer.class, bean.getId_vuelo());
		if(numActPasajeros+1>numMaxPasajeros) {
			throw new RuntimeException("No hay asientos disponibles para este vuelo");
		}
		// Como agarro dos datos de una misma sentencia sql???
		// Incrementar el numero actual de pasajeros del vuelo
		sql = "update VUELO set num_actu_pasajeros =  num_actu_pasajeros + 1 where id_vuelo = ?";
		jdbcTemplate.update(sql, bean.getId_vuelo());
		// Incrementar el numero de vuelos del pasajero
		sql = "update PASAJERO set num_vuelos =  num_vuelos + 1 where id_pasajero = ?";
		jdbcTemplate.update(sql, bean.getId_pasajero());
		//Generar id de reserva
		sql = "select top 1 id_reserva from RESERVA order by id_reserva desc";
		cont = Integer.parseInt(jdbcTemplate.queryForObject(sql, String.class).substring(3));
		cont += 1;
		id_reserva = "000" + cont;
		id_reserva = "RES"+ id_reserva.substring(id_reserva.length() - 3);
		// Registrar Reserva
		sql = "insert into RESERVA (id_reserva, id_pasajero, id_vuelo, fecha_reserva, pago, estado)";
		sql += "values (?,?,?,getdate(),?,?)";
		jdbcTemplate.update(sql, id_reserva, bean.getId_pasajero(), bean.getId_vuelo(), bean.getPago(), estado);
		//Reporte
		bean.setId_reserva(id_reserva);
		bean.setEstado(estado);
		return bean;
	}
	
	@Transactional(propagation = Propagation.REQUIRES_NEW, rollbackFor = Exception.class)
	public MantenimientoDTO realizarMantenimiento(MantenimientoDTO bean) {
		return bean;
	}
	
}
