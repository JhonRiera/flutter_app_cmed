// ignore_for_file: avoid_print, unnecessary_this

import 'dart:convert';

class UserMob {

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