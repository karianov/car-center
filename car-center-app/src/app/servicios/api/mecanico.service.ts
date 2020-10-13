import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Mecanico } from "../../modelos/api/mecanico";
import { API_URL } from "../../constantes/constantes";
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class MecanicoService {
  private endpoint: string;

  constructor(private httpClient: HttpClient) {
    this.endpoint = 'mecanico';
  }

  guardarNuevoMecanico(nuevoMecanico: Mecanico): Observable<Mecanico> {
    const servicio = API_URL + this.endpoint;
    return this.httpClient.post<Mecanico>(servicio, nuevoMecanico);
  }
  
  obtenerMecanicosDisponibles(): Observable<Mecanico[]> {
    const servicio = API_URL + this.endpoint;
    return this.httpClient.get<Mecanico[]>(servicio);
  }
}
