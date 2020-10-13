package co.org.karianov.carcenterapi.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import co.org.karianov.carcenterapi.jpa.repo.MecanicoRepo;
import co.org.karianov.carcenterapi.model.entity.Mecanico;
import co.org.karianov.carcenterapi.service.MecanicoServicio;

@Service(value = "mecanicoServicio")
public class MecanicoServicioImpl implements MecanicoServicio {

	@Autowired
	private MecanicoRepo mecanicoRepo;

	@Override
	public Mecanico guardar(Mecanico newMecanico) {
		try {
			return mecanicoRepo.save(newMecanico);
		} catch (Exception excepcion) {
			System.out.println(excepcion);
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST,
					"Ocurrió un error al intentar guardar el nuevo mecánico.");
		}
	}

	@Override
	public List<Mecanico> obtenerMecanicosDisponibles() {
		try {
			return mecanicoRepo.consultarMecanicosDisponibles();
		} catch (Exception excepcion) {
			System.out.println(excepcion);
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST,
					"Ocurrió un error al consultar los mecánicos disponibles.");
		}
	}

}
