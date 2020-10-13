package co.org.karianov.carcenterapi.service;

import java.util.List;

import co.org.karianov.carcenterapi.model.entity.Mecanico;

public interface MecanicoServicio {

	public Mecanico guardar(Mecanico newMecanico);
	
	public List<Mecanico> obtenerMecanicosDisponibles();
	
}
