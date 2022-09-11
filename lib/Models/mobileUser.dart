// ignore_for_file: avoid_print, unnecessary_this

import 'dart:convert';

class UserMob {

  /* [
  {
    "cod_persona": "1",
    "cedula": "1719624999",
    "nombres": "Jhony",
    "apellidos": "Riera",
    "ocupacion": "ND",
    "estado_civil": "S",
    "pais_origen": "EC",
    "sexo": "M",
    "celular": "0996876674",
    "direccion": "Quito",
    "fecha_nacimiento": "2020-01-01",
    "lugar_nacimiento": "Quito",
    "createdAt": "2020-01-01T05:00:00.000Z",
    "updatedAt": "2020-01-01T05:00:00.000Z",
    "cod_rol": null,
    "usuario": {
      "cod_usuario": "1",
      "email": "jhonyriera@hotmail.com",
      "password": "jhony123",
      "fecha_ultimo_acceso": "2020-10-10T05:00:00.000Z",
      "createdAt": "2020-01-01T05:00:00.000Z",
      "updatedAt": "2020-01-01T05:00:00.000Z"
    }
  }
]*/

  final String cedula;
  final String nombre ;
  final String email;
  // ignore: non_constant_identifier_names
  final String cod_persona ;
  final String sexo ;
  final String fecha_ult_acce ;
  
  // ignore: non_constant_identifier_names
  UserMob({required this.cod_persona, required this.cedula, required this.nombre, required this.sexo, required this.email, required this.fecha_ult_acce});

  factory UserMob.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

  //print(json);
    return UserMob(
      cod_persona: json['cod_persona'], 
      cedula: json["cedula"],
      nombre: json["nombres"],
      sexo:  json["sexo"],
      email: json["usuario"]["email"],
      fecha_ult_acce: json["usuario"]["fecha_ultimo_acceso"]
    );

  }

  void printAttributes() {
    print("cedula: ${this.cedula}\n");
    print("nombre: ${this.nombre}\n");
    print("email: ${this.email}\n");
    print("codigo persona: ${this.cod_persona}\n");
    print("sexo: ${this.sexo}\n");
    print("fecha de ui: ${this.fecha_ult_acce}\n");
  }
  
}