package co.org.karianov.carcenterapi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import co.org.karianov.carcenterapi.model.entity.Mecanico;
import co.org.karianov.carcenterapi.service.MecanicoServicio;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

@RestController
@RequestMapping(path = "/rest/v1/mecanico")
@Api(tags = { "Mecánico" })
public class MecanicoControlador {

	@Autowired
	private MecanicoServicio mecanicoServicio;

	@PostMapping
	@ApiOperation(value = "Create one country", notes = "REST service to insert new countries")
	public ResponseEntity<Mecanico> createCountry(@RequestBody Mecanico newMecanico) {
		return new ResponseEntity<Mecanico>(mecanicoServicio.guardar(newMecanico), HttpStatus.CREATED);
	}

	@GetMapping
	@ApiOperation(value = "Mecánicos disponibles", notes = "Servicio REST para obtener los mecánicos disponibles.")
	public ResponseEntity<List<Mecanico>> getAllCountries() {
		return new ResponseEntity<List<Mecanico>>(mecanicoServicio.obtenerMecanicosDisponibles(), HttpStatus.OK);
	}

}
