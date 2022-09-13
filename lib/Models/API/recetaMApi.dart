import 'dart:convert';
import 'package:cmed_app/Models/API/baseApi.dart';
import 'package:http/http.dart' as http;

class recetaMApi extends BaseApi {
    Future<http.Response> receta(String cod_persona) async {
        var body = jsonEncode({'cod_persona': cod_persona});

    http.Response response =
        await http.post(Uri.parse(super.recetaM), headers: super.headers, body: body);

    return response;
  }
}