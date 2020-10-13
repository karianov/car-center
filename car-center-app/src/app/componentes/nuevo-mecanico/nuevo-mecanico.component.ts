import { Component, OnInit } from '@angular/core';
import {
  AbstractControl,
  FormBuilder,
  FormControl,
  FormGroup,
  Validators,
} from '@angular/forms';
import { finalize } from 'rxjs/operators';
import { Mecanico } from 'src/app/modelos/api/mecanico';
import { MecanicoService } from "../../servicios/api/mecanico.service";

@Component({
  selector: 'app-nuevo-mecanico',
  templateUrl: './nuevo-mecanico.component.html',
  styles: [],
})
export class NuevoMecanicoComponent implements OnInit {
  formularioMecanico: FormGroup;

  cargando: boolean;
  error: boolean;
  valido: boolean;

  constructor(private formBuilder: FormBuilder, private mecanicoServicio: MecanicoService) {}

  ngOnInit(): void {
    this.formularioMecanico = this.formBuilder.group({
      tipoDocumento: new FormControl(null, [
        Validators.required,
        Validators.maxLength(2),
      ]),
      documento: new FormControl(null, [
        Validators.required,
        Validators.minLength(3),
        Validators.maxLength(30),
        Validators.pattern('^[0-9]*$'),
      ]),
      primerNombre: new FormControl(null, [
        Validators.required,
        Validators.minLength(3),
        Validators.maxLength(30),
      ]),
      segundoNombre: new FormControl(null, [
        Validators.maxLength(30),
      ]),
      primerApellido: new FormControl(null, [
        Validators.required,
        Validators.minLength(3),
        Validators.maxLength(30),
      ]),
      segundoApellido: new FormControl(null, [
        Validators.maxLength(30),
      ]),
      celular: new FormControl(null, [
        Validators.required,
        Validators.minLength(3),
        Validators.maxLength(10),
        Validators.pattern('^[0-9]*$'),
      ]),
      direccion: new FormControl(null, [
        Validators.required,
        Validators.minLength(3),
        Validators.maxLength(200),
      ]),
      email: new FormControl(null, [
        Validators.required,
        Validators.minLength(3),
        Validators.maxLength(100),
        Validators.pattern('^[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,4}$'),
      ]),
      estado: new FormControl(null, [
        Validators.required,
        Validators.maxLength(1),
        Validators.pattern('D|N'),
      ]),
    });
  }

  get tipoDocumento(): AbstractControl {
    return this.formularioMecanico.get('tipoDocumento');
  }

  get documento(): AbstractControl {
    return this.formularioMecanico.get('documento');
  }

  get primerNombre(): AbstractControl {
    return this.formularioMecanico.get('primerNombre');
  }

  get segundoNombre(): AbstractControl {
    return this.formularioMecanico.get('segundoNombre');
  }

  get primerApellido(): AbstractControl {
    return this.formularioMecanico.get('primerApellido');
  }

  get segundoApellido(): AbstractControl {
    return this.formularioMecanico.get('segundoApellido');
  }

  get celular(): AbstractControl {
    return this.formularioMecanico.get('celular');
  }

  get direccion(): AbstractControl {
    return this.formularioMecanico.get('direccion');
  }

  get email(): AbstractControl {
    return this.formularioMecanico.get('email');
  }

  get estado(): AbstractControl {
    return this.formularioMecanico.get('estado');
  }

  submit(): void {
    this.cargando = true;
    this.valido = false;
    this.error = false;
    const nuevoMecanico: Mecanico = {
      tipoDocumento: this.tipoDocumento.value,
      documento: this.documento.value,
      primerNombre: this.primerNombre.value,
      segundoNombre: this.segundoNombre.value,
      primerApellido: this.primerApellido.value,
      segundoApellido: this.segundoNombre.value,
      celular: this.celular.value,
      direccion: this.direccion.value,
      email: this.email.value,
      estado: this.estado.value
    }
    this.mecanicoServicio
      .guardarNuevoMecanico(nuevoMecanico)
      .pipe(finalize(() => (this.cargando = false)))
      .subscribe(
        (response) => {
          if (response) {
            this.valido = true;
          } else {
            this.error = true;
          }
        },
        () => {
          this.valido = true;
        }
      );
    this.formularioMecanico.reset();
  }
}
