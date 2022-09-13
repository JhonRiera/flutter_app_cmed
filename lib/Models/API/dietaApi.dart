// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:cmed_app/Models/API/baseApi.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class dietaApi extends BaseApi {
  Future<http.Response> dieta(String cod_persona) async {
        var body = jsonEncode({'cod_persona': cod_persona});

    http.Response response =
        await http.post(Uri.parse(super.dietas), headers: super.headers, body: body);

    return response;
  }
}