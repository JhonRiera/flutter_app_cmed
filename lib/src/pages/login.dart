// ignore_for_file: prefer_final_fields

import 'dart:convert';

import 'package:cmed_app/Models/authApi.dart';
import 'package:cmed_app/Models/medicineApi.dart';
import 'package:cmed_app/Models/medicineUser.dart';
import 'package:cmed_app/Models/modelClass.dart';
import 'package:cmed_app/Models/modelClassMedica.dart';
import 'package:cmed_app/src/pages/navbar.dart';
import 'package:cmed_app/src/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Models/mobileUser.dart';
import '../../Models/modelClass.dart';

// ignore: camel_case_types
class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

// ignore: camel_case_types
class _loginPageState extends State<loginPage> {
  AuthApi _authAPI = AuthApi();

  final _key =  GlobalKey<FormState>();
  String cedula = '';
  String password = '';

  modelClass _modelClass = GetIt.instance.get<modelClass>();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 50),
        children: <Widget>[
          _imagen(),
          _titulo(),
          const Divider(
            color: Colors.transparent
          ),
          _inputUsuario(),
           const Divider(
            color: Colors.transparent,
            height: 25.0,
          ),
          _inputPassword(),
          const Divider(
            color: Colors.transparent,
            height: 60.0,
          ),
          _boton(context)
        ],
      ),
    );
  }
  
 Widget _imagen() {
  return Container(
    margin: const EdgeInsets.fromLTRB(0, 50.0, 0, 0),
    child: const Image(
    image: AssetImage('assets/heart.png'),
    color:Color.fromRGBO(71, 122, 213, 1),
    width: 200.0,
    height: 150.0,
    ),
  );
 }
 
Widget _titulo() {
  return Container(
    margin: const EdgeInsets.fromLTRB(140.0, 20.0, 5, 5),
    child:  RichText(text: TextSpan(
    text: 'Paciente',
    style: GoogleFonts.cabin(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: const Color.fromRGBO(71, 122, 213, 1)
    ))
  )
  );
}

Widget _inputUsuario() {
  return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: 'Escriba su cédula',
        labelText: 'Cédula',
        //helperText: 'Escriba solamente su cédula',
        suffixIcon: const Icon(Icons.account_circle),
      ),
      onChanged: (val) => setState(() => cedula = val),
    );
}

Widget _inputPassword() {
  return TextField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: 'Escriba su password',
        labelText: 'Password',
        //helperText: 'Escriba solamente el password',
        suffixIcon: const Icon(Icons.lock_open),
      ),
      onChanged: (val) => setState(() => password = val),
    );
}

Widget _boton(BuildContext context) {
  return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
          colors: <Color>[
                Color(0xFF0D47A1),
                Color(0xFF1976D2),
                Color(0xFF42A5F5),
                ],
          ),
        ),
          child: TextButton(
            style: TextButton.styleFrom(
            padding: const EdgeInsets.all(16.0),
            primary: Colors.white,
            textStyle: const TextStyle(fontSize: 19),
          ),
          onPressed: () async {
            try{
              //REQ de login
              var req = await _authAPI.login(cedula, password);
              
              if(req.statusCode == 200 && req.body.isNotEmpty) {
                //Obtenemos el objeto usuario con uss atributos
                var user = UserMob.fromReqBody(req.body);
                user.printAttributes();
                //PATRON SINGLETON
                _modelClass.setValores(user);
               
                // ignore: use_build_context_synchronously
                Navigator.push(context, PageTransition(
                type: PageTransitionType.fade,
                child: splashScreen(),
                isIos: false,
                duration: const Duration(milliseconds: 400)
                ));
            
              }
              else{
                Fluttertoast.showToast(
                  msg: "Credenciales incorrectas, por favor vuelva a intentarlo",  // message
                  toastLength: Toast.LENGTH_SHORT, // length
                  gravity: ToastGravity.CENTER,    // location
                  timeInSecForIosWeb: 5               // duration
                );
              }
            }
            catch(error){
              print(error);
            }
           
          },
            child: const Text('Iniciar Sesión'),
          ),
  );
}


}

