// ignore_for_file: non_constant_identifier_names, avoid_print, unnecessary_this

import 'dart:convert';
import 'dart:ffi';

import 'package:cmed_app/Models/alarmUser.dart';

class Progreso {
  final String medicamento;
  final String dosis;
  List<Alarma> alarmas;
  /*final String cod_alarma;
  final bool estado;
  final String tiempo_recordatorio;*/

  Progreso({
    required this.medicamento,
    required this.dosis,
    required this.alarmas,
    /*required this.cod_alarma,
    required this.estado,
    required this.tiempo_recordatorio,*/
  });

  factory Progreso.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    var alarmas = jsonDecode(body)['receta_medicamentos'][0]['alarmas'] as List;
    //print(alarmas);
    List<Alarma> listAlarm = alarmas.map((medicamentoTag) => Alarma.fromJson(medicamentoTag)).toList();
    //print(":::::: " + listAlarm.length.toString());
    return Progreso(
      medicamento: json["nombre"] as String,
      dosis: json['receta_medicamentos'][0]['dosis'],
      alarmas: listAlarm
      //cod_alarma: json["receta_medicamentos"][0]["alarmas"][0]["cod_alarma"] as String,
      //estado: json["receta_medicamentos"][0]["alarmas"][0]["estado"] as bool,
      //tiempo_recordatorio: json["receta_medicamentos"][0]["alarmas"][0]["tiempo_recordatorio"] as String
    );
  }

  void printAttributes() {
    print("medicamento: ${this.medicamento}\n");
    print("dosis: ${this.dosis}\n");
    print("alarmas: ${this.alarmas}\n");
    /*print("cod_alarma: ${this.cod_alarma}\n");
    print("estado: ${this.estado}\n");
    print("tiempo_recor: ${this.tiempo_recordatorio}\n");*/
  }
}