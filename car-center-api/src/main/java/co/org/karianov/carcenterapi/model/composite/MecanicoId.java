package co.org.karianov.carcenterapi.model.composite;

import java.io.Serializable;
import java.util.Objects;

public class MecanicoId implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5235196532556803317L;

	private String tipoDocumento;
	private Integer documento;

	public MecanicoId() {
	}

	public MecanicoId(String tipoDocumento, Integer documento) {
		this.tipoDocumento = tipoDocumento;
		this.documento = documento;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null || getClass() != obj.getClass()) {
			return false;
		}
		MecanicoId mecanicoId = (MecanicoId) obj;
		return tipoDocumento.equals(mecanicoId.tipoDocumento) && documento.equals(mecanicoId.documento);
	}

	@Override
	public int hashCode() {
		return Objects.hash(tipoDocumento, documento);
	}
}
