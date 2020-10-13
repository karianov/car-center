import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NuevoMecanicoComponent } from './nuevo-mecanico/nuevo-mecanico.component';
import { AsignacionMecanicoComponent } from './asignacion-mecanico/asignacion-mecanico.component';
import { ReactiveFormsModule } from '@angular/forms';
import { MDBBootstrapModule } from 'angular-bootstrap-md';

@NgModule({
  declarations: [NuevoMecanicoComponent, AsignacionMecanicoComponent],
  imports: [CommonModule, ReactiveFormsModule, MDBBootstrapModule.forRoot()],
  exports: [NuevoMecanicoComponent, AsignacionMecanicoComponent],
})
export class ComponentesModule {}
