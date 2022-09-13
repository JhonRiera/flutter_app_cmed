import 'dart:convert';

class ConsultaReceta {
  String descripcion;
  String fCreacion;

  ConsultaReceta({
    required this.descripcion,
    required this.fCreacion,
  });

  factory ConsultaReceta.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    return ConsultaReceta(
      descripcion: json['receta_medica']['descripcion'] as String,
      fCreacion: json['receta_medica']['createdAt'] as String,
    );
  }

  void printAttributes(){
    print("descripcion: ${this.descripcion}\n");
    print("fecha atencion: ${this.fCreacion}\n");
  }

}