package pe.edu.uni.app.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor

public class ReservaDTO {
	private String id_reserva;
	private String id_pasajero;
	private String id_vuelo;
	private double pago;
	private String estado;
}
