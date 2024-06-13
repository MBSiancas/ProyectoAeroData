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
import pe.edu.uni.app.dto.VueloDTO;

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
		// Verificar el numero de pasaporte (si ya existe, entonces tendria que hacer reserva)
		sql = "select count(1) cont from PASAJERO where num_pasaporte = ?";
		cont = jdbcTemplate.queryForObject(sql, Integer.class, bean.getNum_pasaporte());
		if (cont == 1) {
			throw new RuntimeException("El pasajero ya está registrado");
		}
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
		String sql, estado = null, id_reserva;
		double pagoReserva, costoVuelo;
		int cont, numActPasajeros, numMaxPasajeros;
		// Verificar que exista el vuelo
		verificarVuelo(bean.getId_vuelo());
		// Verificar el numero de id del pasajero (si no existe, tendria que pasar al service de crearPasajero)
		sql = "select count(1) cont from PASAJERO where id_pasajero = ?";
		cont = jdbcTemplate.queryForObject(sql, Integer.class, bean.getId_pasajero());
		if (cont != 1) {
			throw new RuntimeException("El pasajero no está registrado");
		}
		// Verificar pago de la reserva
		pagoReserva = bean.getPago();
		sql = "select precio from VUELO where id_vuelo = ?";
		costoVuelo = jdbcTemplate.queryForObject(sql, Double.class, bean.getId_vuelo());
		if (pagoReserva < costoVuelo && pagoReserva >= 0) {
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
		if (numActPasajeros + 1 > numMaxPasajeros) {
			throw new RuntimeException("No hay asientos disponibles para este vuelo");
		}
		// Incrementar el numero actual de pasajeros del vuelo
		sql = "update VUELO set num_actu_pasajeros =  num_actu_pasajeros + 1 where id_vuelo = ?";
		jdbcTemplate.update(sql, bean.getId_vuelo());
		// Incrementar el numero de vuelos del pasajero
		sql = "update PASAJERO set num_vuelos =  num_vuelos + 1 where id_pasajero = ?";
		jdbcTemplate.update(sql, bean.getId_pasajero());
		// Generar id de reserva
		sql = "select top 1 id_reserva from RESERVA order by id_reserva desc";
		cont = Integer.parseInt(jdbcTemplate.queryForObject(sql, String.class).substring(3));
		cont += 1;
		id_reserva = "000" + cont;
		id_reserva = "RES" + id_reserva.substring(id_reserva.length() - 3);
		// Registrar Reserva
		sql = "insert into RESERVA (id_reserva, id_pasajero, id_vuelo, fecha_reserva, pago, estado)";
		sql += "values (?,?,?,getdate(),?,?)";
		jdbcTemplate.update(sql, id_reserva, bean.getId_pasajero(), bean.getId_vuelo(), bean.getPago(), estado);
		// Reporte
		bean.setId_reserva(id_reserva);
		bean.setEstado(estado);
		return bean;
	}

	@Transactional(propagation = Propagation.REQUIRES_NEW, rollbackFor = Exception.class)
	public ReservaDTO cancelarReserva(ReservaDTO bean) {
		// Variables
		String sql;
		// Verificar id_reserva
		verificarReserva(bean.getId_reserva());
		//Recuperar el id_pasajero y el id_vuelo
		sql = "select id_pasajero, id_vuelo, pago from RESERVA where id_reserva = ?";
		jdbcTemplate.query(sql, (rs, rowNum) -> { 
			  bean.setId_pasajero(rs.getString("id_pasajero")); 
			  bean.setId_vuelo(rs.getString("id_vuelo")); 
			  bean.setPago(rs.getDouble("pago"));
			  return bean;
			 }, bean.getId_reserva()); 
		// Actulizar reserva a estado cancelado
		sql = "update RESERVA set estado = 'Cancelado'";
		jdbcTemplate.update(sql);
		bean.setEstado("Cancelado");
		// Actualizar la tabla pasajeros
		sql = "update PASAJERO set num_vuelos = num_vuelos-1 where id_pasajero = ?";
		jdbcTemplate.update(sql, bean.getId_pasajero());
		//Actualizar la tabla de vuelos
		sql = "update VUELO set num_actu_pasajeros = num_actu_pasajeros-1";
		jdbcTemplate.update(sql);
		// Reporte
		return bean;
	}

	@Transactional(propagation = Propagation.REQUIRES_NEW, rollbackFor = Exception.class)
	public MantenimientoDTO realizarMantenimiento(MantenimientoDTO bean) {
		// Variables
		String sql, id_mantenimiento;
		int cont;
		// Verificar que exista el aeropuerto
		sql = "select count(1) cont from AEROPUERTO where id_aeropuerto = ?";
		cont = jdbcTemplate.queryForObject(sql, Integer.class, bean.getId_aeropuerto());
		if (cont != 1) {
			throw new RuntimeException("El aeropuerto no existe");
		}
		// Generar id para el mantenimiento
		sql = "select top 1 id_mantenimiento from MANTENIMIENTO order by id_mantenimiento desc";
		cont = Integer.parseInt(jdbcTemplate.queryForObject(sql, String.class).substring(3)) + 1;
		id_mantenimiento = "MAN" + String.format("%03d", cont);
		// Registrar un nuevo mantenimiento en el aeropuerto correspondiente
		sql = "insert into MANTENIMIENTO (id_mantenimiento, id_aeropuerto, descripcion, fecha_inicio, fecha_fin) ";
		sql += "values (?, ?, ?, getdate(), dateadd(day, 1, getdate()))";
		jdbcTemplate.update(sql, id_mantenimiento, bean.getId_aeropuerto(), bean.getDescripcion());
		// Poner en pendiente todas las reservas de los vuelos del aeropuerto afectado
		sql = "UPDATE RESERVA SET estado = 'Pendiente' ";
		sql += "WHERE id_vuelo IN (";
		sql += "SELECT id_vuelo FROM VUELO WHERE id_aeropuerto = ?);";
		jdbcTemplate.update(sql, bean.getId_aeropuerto());
		// Reporte
		sql = "select fecha_inicio from MANTENIMIENTO where id_mantenimiento = ?";
		bean.setFecha_inicio(jdbcTemplate.queryForObject(sql, String.class, id_mantenimiento));
		sql = "select fecha_fin from MANTENIMIENTO where id_mantenimiento = ?";
		bean.setFecha_fin(jdbcTemplate.queryForObject(sql, String.class, id_mantenimiento));
		bean.setId_mantenimiento(id_mantenimiento);
		return bean;
	}

	@Transactional(propagation = Propagation.REQUIRES_NEW, rollbackFor = Exception.class)
	public VueloDTO reprogramarVuelo(VueloDTO bean) {
		// Variables
		String sql;
		// Verificar que el vuelo exista
		verificarVuelo(bean.getId_vuelo());
		// Actualizar la fecha del vuelo
		sql = "update VUELO set fecha = ? where id_vuelo = ?";
		jdbcTemplate.update(sql, bean.getFecha(), bean.getId_vuelo());
		// Cambiar el estado de las reservas a pendiente
		sql = "update RESERVA set estado = 'Pendiente' where id_vuelo = ?";
		jdbcTemplate.update(sql, bean.getId_vuelo());
		// Reporte
		sql = "select id_aeropuerto, id_compañia, ciudad_origen, ciudad_destino, precio, ";
		sql += "num_max_pasajeros, num_actu_pasajeros from VUELO where id_vuelo = ?";
		jdbcTemplate.query(sql, (rs, rowNum) -> { 
			  bean.setId_aeropuerto(rs.getString("id_aeropuerto"));
			  bean.setId_compañia(rs.getString("id_compañia"));
			  bean.setCiudad_origen(rs.getString("ciudad_origen"));
			  bean.setCiudad_destino(rs.getString("ciudad_destino"));
			  bean.setPrecio(rs.getDouble("precio"));
			  bean.setNum_max_pasajeros(rs.getInt("num_max_pasajeros"));
			  bean.setNum_actu_pasajeros(rs.getInt("num_actu_pasajeros"));
			  return bean;
			 }, bean.getId_vuelo()); 
		return bean;
	}

	@Transactional(propagation = Propagation.NESTED)
	private void verificarVuelo(String id_vuelo) {
		String sql = "select count(1) cont from VUELO where id_vuelo = ?";
		int cont = jdbcTemplate.queryForObject(sql, Integer.class, id_vuelo);
		if (cont != 1) {
			throw new RuntimeException("El vuelo no existe");
		}
	}

	@Transactional(propagation = Propagation.NESTED)
	private void verificarReserva(String id_reserva) {
		String sql = "select count(1) cont from RESERVA where id_reserva = ?";
		int cont = jdbcTemplate.queryForObject(sql, Integer.class, id_reserva);
		if (cont != 1) {
			throw new RuntimeException("La reserva no existe");
		}
	}
}
