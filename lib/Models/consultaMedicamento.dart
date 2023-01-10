import 'dart:convert';

import 'package:cmed_app/Models/medicineUser.dart';

class ConsultaMedicamento {
  String cod_consulta;
  String cod_receta;
  List<Medicamento> medicamentos;

  ConsultaMedicamento({
    required this.cod_consulta,
    required this.cod_receta,
    required this.medicamentos,
  }); 

  factory ConsultaMedicamento.fromReqBody(String body){
    Map<String, dynamic> json = jsonDecode(body);
    /*var list = json["receta_medica"]["receta_medicamentos"] as List;
    print(list[0]["medicamento"]["nombre"]);*/
    //----- Obtener un listado de los medicamentos ----///
    var medicamentos = jsonDecode(body)['receta_medica']['receta_medicamentos'] as List;
    // ------Aniado a la lista de la clase de mendicamenntos
    List<Medicamento> listMedicam = medicamentos.map((medicamentoTag) => Medicamento.fromJson(medicamentoTag)).toList();
    return ConsultaMedicamento(
      cod_consulta: json["cod_consulta"],
      cod_receta: json["receta_medica"]["cod_receta"],
      medicamentos: listMedicam
    );
  }

  void printAttributes(){
    print("cod cosnulta: ${this.cod_consulta}\n");
    print("cod receta: ${this.cod_receta}\n");
    print("medicamentos: ${this.medicamentos}\n");
  }
}