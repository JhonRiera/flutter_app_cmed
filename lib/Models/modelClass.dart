// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:cmed_app/Models/mobileUser.dart';

class modelClass {
  String cedula = " ";
  String nombre = " ";
  String email = " ";
  // ignore: non_constant_identifier_names
  String cod_persona = " " ;
  String sexo = " ";
  String fecha_ult_acceso = " ";

  String get _cedula => cedula;
  String get _nombre => nombre;
  String get _email => email;
  String get _cod_persona => cod_persona;
  String get _sexo => sexo;
  String get _fecha_ult_acceso => fecha_ult_acceso;

  setValores(UserMob uservals) {
    cedula = uservals.cedula;
    nombre = uservals.nombre;
    email = uservals.email;
    cod_persona = uservals.cod_persona;
    sexo = uservals.sexo;
    fecha_ult_acceso = uservals.fecha_ult_acce;

  }
}