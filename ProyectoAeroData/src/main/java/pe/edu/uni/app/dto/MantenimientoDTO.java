package pe.edu.uni.app.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor
public class MantenimientoDTO {
	private String id_mantenimiento;
	private String id_aeropuerto;
	private String descripcion;
	private String fecha_inicio;
	private String fecha_fin;
}
