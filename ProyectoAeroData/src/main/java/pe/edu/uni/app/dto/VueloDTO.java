package pe.edu.uni.app.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor

public class VueloDTO {
	private String id_vuelo;
	private String id_aeropuerto;
	private String id_compañia;
	private String ciudad_origen;
	private String ciudad_destino;
	private Date fecha;
	private double precio;
	private int num_max_pasajeros;
	private int num_actu_pasajeros;
}
