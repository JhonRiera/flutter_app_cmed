import 'package:cmed_app/Models/authApi.dart';
import 'package:cmed_app/Models/mobileUser.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


const userJson = '{"cod_persona":"1","cedula":"1719624999","nombres":"Martina","sexo":"F","usuario":{"email":"martinaflores_90@gmail.com","fecha_ultimo_acceso":"2023-01-17T21:16:07.556Z"}}';


UserMob expectedApiUniversityOne = UserMob(
        cod_persona: "1",
        cedula: "1719624999",
        nombre: "Martina",
        sexo: 'F',
        email: 'martinaflores_90@gmail.com',
        fecha_ult_acce: "2023-01-17T21:16:07.556Z"
);

final expectedUser = UserMob(
    cod_persona: "1",
    cedula: "1719624999",
    nombre: "Martina",
    sexo: 'F',
    email: 'martinaflores_90@gmail.com',
    fecha_ult_acce: "2023-01-17T21:16:07.556Z"
);

void main() {
  group("Tests ALFA", (){
    test('Test using api', (){
      expect(UserMob.fromReqBody(userJson).cod_persona, '1');
      expect(UserMob.fromReqBody(userJson).cedula, '1719624999');
      expect(UserMob.fromReqBody(userJson).nombre, 'Martina');
      expect(UserMob.fromReqBody(userJson).sexo, 'F');
      expect(UserMob.fromReqBody(userJson).email, 'martinaflores_90@gmail.com');
      expect(UserMob.fromReqBody(userJson).fecha_ult_acce, '2023-01-17T21:16:07.556Z');
    });

final parsedUser = UserMob.fromReqBody(userJson);
    test('Parseo', (){
      expect(parsedUser.cod_persona, expectedUser.cod_persona);
      expect(parsedUser.cedula, expectedUser.cedula);
      expect(parsedUser.nombre, expectedUser.nombre);
      expect(parsedUser.sexo, expectedUser.sexo);
      expect(parsedUser.email, expectedUser.email);
      expect(parsedUser.fecha_ult_acce, expectedUser.fecha_ult_acce);
    });
  });

  
}


