
// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:cmed_app/Models/consultaMedicamento.dart';

import 'medicineUser.dart';

class modelClassMedica{
  String cod_consulta = " ";
  String cod_receta = " ";
  List<Medicamento> medicamentos = [];

  setValores(ConsultaMedicamento vals) {
    cod_consulta = vals.cod_consulta;
    cod_receta = vals.cod_receta;
    medicamentos = vals.medicamentos;
  }
}