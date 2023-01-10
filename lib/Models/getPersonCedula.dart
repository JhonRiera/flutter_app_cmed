
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class getPersonCedula {
  String cod_persona;
  String cedula;
  String nombres;
  String apellidos;

  getPersonCedula({
    required this.cod_persona,
    required this.cedula,
    required this.nombres,
    required this.apellidos,
  });

  factory getPersonCedula.fromReqBody(String body) {
        Map<String, dynamic> json = jsonDecode(body);

    return getPersonCedula(
      cod_persona: json["cod_persona"] as String, 
      cedula: json["cedula"] as String, 
      nombres: json["nombres"] as String, 
      apellidos: json["apellidos"] as String
    );

  }
}