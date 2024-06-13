package pe.edu.uni.app.rest;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import pe.edu.uni.app.dto.MantenimientoDTO;
import pe.edu.uni.app.dto.PasajeroDTO;
import pe.edu.uni.app.dto.ReservaDTO;
import pe.edu.uni.app.dto.VueloDTO;
import pe.edu.uni.app.service.AeroDataService;

@RequestMapping("/aerodata")
@RestController

public class AeroDataRest {
	
	@Autowired
	private AeroDataService aerodataService;
	
	@GetMapping("/vuelos")
	public List<Map<String,Object>> listadoVuelos(){
		return aerodataService.getVuelos();
	}
	
	@PostMapping("/pasajero/crear")
	public ResponseEntity<?> crearPasajero(@RequestBody PasajeroDTO bean){
		try {
			aerodataService.crearPasajero(bean);
			return ResponseEntity.ok(bean);
		}catch (Exception e) {
			ErrorResponse error;
			error = new ErrorResponse(e.getMessage(), HttpStatus.CONFLICT.value());
			return ResponseEntity.status(HttpStatus.CONFLICT).body(error);
		}
	}
	
	@PostMapping("/reserva/crear")
	public ResponseEntity<?> crearReserva(@RequestBody ReservaDTO bean){
		try {
			aerodataService.crearReserva(bean);
			return ResponseEntity.ok(bean);
		}catch (Exception e) {
			ErrorResponse error;
			error = new ErrorResponse(e.getMessage(), HttpStatus.CONFLICT.value());
			return ResponseEntity.status(HttpStatus.CONFLICT).body(error);
		}
	}
	
	@PutMapping("/reserva/cancelar")
	public ResponseEntity<?> cancelarReserva(@RequestBody ReservaDTO bean){
		try {
			aerodataService.cancelarReserva(bean);
			return ResponseEntity.ok(bean);
		}catch (Exception e) {
			ErrorResponse error;
			error = new ErrorResponse(e.getMessage(), HttpStatus.CONFLICT.value());
			return ResponseEntity.status(HttpStatus.CONFLICT).body(error);
		}
	}
	
	@PostMapping("/mantenimiento/realizar")
	public ResponseEntity<?> realizarMantenimiento(@RequestBody MantenimientoDTO bean){
		try {
			aerodataService.realizarMantenimiento(bean);
			return ResponseEntity.ok(bean);
		}catch (Exception e) {
			ErrorResponse error;
			error = new ErrorResponse(e.getMessage(), HttpStatus.CONFLICT.value());
			return ResponseEntity.status(HttpStatus.CONFLICT).body(error);
		}
	}
	
	@PutMapping("/vuelo/reprogramar")
	public ResponseEntity<?> reprogramarVuelo(@RequestBody VueloDTO bean){
		try {
			aerodataService.reprogramarVuelo(bean);
			return ResponseEntity.ok(bean);
		}catch (Exception e) {
			ErrorResponse error;
			error = new ErrorResponse(e.getMessage(), HttpStatus.CONFLICT.value());
			return ResponseEntity.status(HttpStatus.CONFLICT).body(error);
		}
	}
	
}
