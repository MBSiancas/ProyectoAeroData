package pe.edu.uni.app.rest;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor

public class ErrorResponse {
	private String message;
	private int status;
}