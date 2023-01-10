// ignore: file_names
// ignore_for_file: non_constant_identifier_names, camel_case_types, file_names, duplicate_ignore

import 'dart:convert';
import 'package:cmed_app/Models/API/BaseApi.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class medicineApi extends BaseApi {

  Future<http.Response> medicamento(String cod_persona) async {
    var body = jsonEncode({'cod_persona': cod_persona});

    http.Response response =
        await http.post(Uri.parse(super.medicamentos), headers: super.headers, body: body);

    return response;
  }


}