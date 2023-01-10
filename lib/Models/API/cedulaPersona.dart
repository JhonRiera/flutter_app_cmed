import 'dart:convert';

import 'package:cmed_app/Models/API/baseApi.dart';
import 'package:http/http.dart' as http;

class CedulaPersona extends BaseApi {
  Future<http.Response> cedulaPersona(String cedulaPersona) async {
    var body = jsonEncode({ 'cedula_persona': cedulaPersona});

    http.Response response =
        await http.post(Uri.parse(super.obtenerPersonaCedula), headers: super.headers, body: body);
  
    return response;
  }
}