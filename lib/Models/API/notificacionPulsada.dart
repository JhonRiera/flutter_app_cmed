import 'dart:convert';
import 'package:cmed_app/Models/API/baseApi.dart';
import 'package:http/http.dart' as http;

class actualizarAlarmaNoti extends BaseApi {
  Future<http.Response> actualizarAl(String codAlarma) async {
    String estado = "true";
    var body = jsonEncode({'cod_alarma': codAlarma, 'estado': estado});

    http.Response response = 
      await http.put(Uri.parse(super.actualizarAlarma), headers: super.headers, body: body);
    
    return response;
  }
}