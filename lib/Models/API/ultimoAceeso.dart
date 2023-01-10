// ignore_for_file: camel_case_types

import 'dart:convert';
import 'package:cmed_app/Models/API/baseApi.dart';
import 'package:http/http.dart' as http;

class ultimoAccesoApi extends BaseApi {
  Future<http.Response> usuarioUltimoAcc(String codUsuario, String fechaUltimoAcceso) async {
    var body = jsonEncode({'cod_usuario': codUsuario, 'fecha_ultimo_acceso': fechaUltimoAcceso});

     http.Response response =
        await http.put(Uri.parse(super.actualizaUltAcesso), headers: super.headers, body: body);

    return response;
  }
}