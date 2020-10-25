package co.org.karianov.carcenterapi.jpa.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import co.org.karianov.carcenterapi.model.composite.MecanicoId;
import co.org.karianov.carcenterapi.model.entity.Mecanico;

public interface MecanicoRepo extends JpaRepository<Mecanico, MecanicoId> {

	@Query(value = "SELECT mec.tipo_documento, mec.documento, mec.primer_nombre, mec.segundo_nombre, mec.primer_apellido, mec.segundo_apellido, mec.celular, mec.direccion, mec.email, mec.estado, (SELECT COALESCE(SUM(ser.tiempo_estimado), 0) FROM car_center_db.servicio_x_mantenimiento AS ser WHERE ser.cod_mantenimiento = man.codigo  AND man.fecha < DATE_SUB(NOW(), INTERVAL 1 MONTH)) AS horas FROM car_center_db.mecanico AS mec LEFT JOIN car_center_db.mantenimiento AS man ON mec.tipo_documento = man.mec_tipo_documento AND mec.documento = man.mec_documento WHERE mec.estado = 'D' ORDER BY horas DESC LIMIT 10", nativeQuery = true)
	public List<Mecanico> consultarMecanicosDisponibles();

}
