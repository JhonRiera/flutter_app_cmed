import 'dart:convert';

class ConsultaDieta {
  String tpoDieta;
  String detalle;
  String feCreacion;

  ConsultaDieta({
    required this.tpoDieta,
    required this.detalle,
    required this.feCreacion,
  });

  factory ConsultaDieta.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    return ConsultaDieta(
      tpoDieta: json['receta_medica']['dietum']['tipo_dieta'] as String,
      detalle: json['receta_medica']['dietum']['detalle'] as String,
      feCreacion: json['receta_medica']['dietum']['createdAt'] as String,
    );
  }

  void printAttributes() {
    print("tipo dieta: ${this.tpoDieta}\n");
    print("detalle: ${this.detalle}\n");
    print("fecha creacion: ${this.feCreacion}\n");
  }
}