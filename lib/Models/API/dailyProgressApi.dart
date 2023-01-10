// ignore_for_file: file_names, depend_on_referenced_packages

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cmed_app/Models/API/baseApi.dart';

class DailyProgress extends BaseApi {
 Future<http.Response> dailyProgss(String codRecetaMedic, String fechaH) async {
    var body = jsonEncode({ 'cod_receta_medica': codRecetaMedic,'date': fechaH});

    http.Response response =
        await http.post(Uri.parse(super.progresoDiario), headers: super.headers, body: body);
  
    return response;
  }
}