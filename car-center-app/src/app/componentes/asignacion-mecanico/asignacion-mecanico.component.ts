import { Component, OnInit } from '@angular/core';
import { MecanicoService } from 'src/app/servicios/api/mecanico.service';
import { finalize } from 'rxjs/operators';
import { Mecanico } from 'src/app/modelos/api/mecanico';

@Component({
  selector: 'app-asignacion-mecanico',
  templateUrl: './asignacion-mecanico.component.html',
  styles: [],
})
export class AsignacionMecanicoComponent implements OnInit {
  cargando: boolean;
  error: boolean;
  valido: boolean;

  mecanicos: Mecanico[];

  constructor(private mecanicoServicio: MecanicoService) {}

  ngOnInit(): void {
    this.cargar();
  }

  cargar(): void {
    this.cargando = true;
    this.valido = false;
    this.error = false;
    this.mecanicoServicio
      .obtenerMecanicosDisponibles()
      .pipe(finalize(() => (this.cargando = false)))
      .subscribe(
        (response) => {
          if (response) {
            this.mecanicos = response;
            this.valido = true;
          } else {
            this.error = true;
          }
        },
        () => {
          this.valido = true;
        }
      );
  }
}
