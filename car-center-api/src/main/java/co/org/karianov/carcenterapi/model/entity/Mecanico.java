package co.org.karianov.carcenterapi.model.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;

import co.org.karianov.carcenterapi.model.composite.MecanicoId;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "mecanico")
@Getter
@Setter
@IdClass(value = MecanicoId.class)
public class Mecanico implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7618741732297408457L;

	@Id
	@Column(name = "tipo_documento", length = 2, nullable = false)
	private String tipoDocumento;

	@Id
	@Column(name = "documento", length = 11, nullable = false)
	private Integer documento;

	@Column(name = "primer_nombre", length = 30, nullable = false)
	private String primerNombre;

	@Column(name = "segundo_nombre", length = 30)
	private String segundoNombre;

	@Column(name = "primer_apellido", length = 30, nullable = false)
	private String primerApellido;

	@Column(name = "segundo_apellido", length = 30)
	private String segundoApellido;

	@Column(name = "celular", length = 10, nullable = false)
	private String celular;

	@Column(name = "direccion", length = 200, nullable = false)
	private String direccion;

	@Column(name = "email", length = 100, nullable = false)
	private String email;

	@Column(name = "estado", length = 1, nullable = false, columnDefinition = "char")
	private String estado;

}
