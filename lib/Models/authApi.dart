// ignore: file_names
import 'dart:convert';
import 'package:cmed_app/Models/API/BaseApi.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class AuthApi extends BaseApi {

  Future<http.Response> signUp(String cedula, String nombre, String email,
      String password, String passwordConfirmation) async {
    var body = jsonEncode({
      /*' ':*/ {
        'cedula': cedula,
        'nombre':nombre,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation
      }
    });

    http.Response response =
        await http.post(Uri.parse(super.mobileUsers), headers: super.headers, body: body);
        
    return response;
  }

  Future<http.Response> login(String cedula, String password) async {
    var body = jsonEncode({'cedula': cedula, 'password': password});

    http.Response response =
        await http.post(Uri.parse(super.mobileUsers), headers: super.headers, body: body);

    return response;
  }


  /*Future<http.Response> logout(int id, String token) async {
    var body = jsonEncode({'id': id, 'token': token});

    http.Response response = await http.post(super.logoutPath,
        headers: super.headers, body: body);

    return response;
  }*/


}