// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Medicamento {

  String cod_receta_medica;
  int dias;
  int frecuencia;
  String dosis;
  bool estado;
  String fechaCreacion;
  String nombreMedicamento;


  Medicamento({
    required this.cod_receta_medica,
    required this.dias,
    required this.frecuencia,
    required this.dosis,
    required this.estado,
    required this.fechaCreacion,
    required this.nombreMedicamento,
  });

  factory Medicamento.fromJson(dynamic json) {
    return Medicamento(
      cod_receta_medica: json["cod_receta_medica"] as String,
      dias: json["dias"] as int,
      frecuencia: json["frecuencia"] as int,
      dosis: json["dosis"],
      estado: json["estado"] as bool, 
      fechaCreacion: json["createdAt"] as String,
      nombreMedicamento: json["medicamento"]["nombre"]
    );
  }

  void printAttributes(){
    print("cod_receta_medica: ${this.cod_receta_medica}\n");
    print("dias: ${this.dias}\n");
    print("frecuencia: ${this.frecuencia}\n");
    print("dosis: ${this.dosis}\n");
    print("estado: ${this.estado}\n");
    print("medicacion: ${this.nombreMedicamento}\n");
    print("fecha de medicacion: ${this.fechaCreacion}");

  }

  
}