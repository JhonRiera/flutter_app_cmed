import 'dart:convert';

class Medicamento {

  int dias;
  int frecuencia;
  String dosis;
  bool estado;
  String nombreMedicamento;

  Medicamento({
    required this.dias,
    required this.frecuencia,
    required this.dosis,
    required this.estado,
    required this.nombreMedicamento,
  });

  factory Medicamento.fromJson(dynamic json) {
    return Medicamento(
      dias: json["dias"] as int,
      frecuencia: json["frecuencia"] as int,
      dosis: json["dosis"],
      estado: json["estado"] as bool, 
      nombreMedicamento: json["medicamento"]["nombre"],
    );
  }

  void printAttributes(){
    print("dias: ${this.dias}\n");
    print("frecuencia: ${this.frecuencia}\n");
    print("dosis: ${this.dosis}\n");
    print("estado: ${this.estado}\n");
    print("medicacion: ${this.nombreMedicamento}\n");

  }

  
}