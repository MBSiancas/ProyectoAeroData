package pe.edu.uni.app.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor

public class PasajeroDTO {
	private String id_pasajero;
	private String nombre;
	private String num_pasaporte;
	private String nacionalidad;
	private int num_vuelos;
	private String email;
	private String telefono;
}
