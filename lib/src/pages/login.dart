// ignore_for_file: prefer_final_fields

import 'dart:convert';

import 'dart:developer' as developer;
import 'dart:isolate';
import 'dart:ui';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:cmed_app/Models/API/dietaApi.dart';
import 'package:cmed_app/Models/API/notification_api.dart';
import 'package:cmed_app/Models/API/recetaMApi.dart';
import 'package:cmed_app/Models/authApi.dart';
import 'package:cmed_app/Models/API/medicineApi.dart';
import 'package:cmed_app/Models/consultaDieta.dart';
import 'package:cmed_app/Models/consultaReceta.dart';
import 'package:cmed_app/Models/medicineUser.dart';
import 'package:cmed_app/Models/modelClass.dart';
import 'package:cmed_app/Models/modelClassDietas.dart';
import 'package:cmed_app/Models/modelClassMedica.dart';
import 'package:cmed_app/Models/modelClassRecetaM.dart';
import 'package:cmed_app/src/pages/navbar.dart';
import 'package:cmed_app/src/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

import '../../Models/consultaMedicamento.dart';
import '../../Models/mobileUser.dart';
import '../../Models/modelClass.dart';
import '../../main.dart';


// ignore: camel_case_types
class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

// ignore: camel_case_types
class _loginPageState extends State<loginPage> {
  late final LocalNotificationService service;
  int _counter = 0;
  bool passwordVisible=false;

  @override
  void initState() {
    super.initState();
    passwordVisible=true;
    //port.listen((_) async => await _incrementCounter());
    printHello();
  }

  Future<void> _incrementCounter() async {
    developer.log('Increment counter!');
    // Ensure we've loaded the updated count from the background isolate.
    await prefs?.reload();

    setState(() {
      _counter++;
    });
  }

  // API DE AUTENTICACION USUARIOS
  AuthApi _authAPI = AuthApi();
  //API DE MEDICAMENTOS USUARIO
  medicineApi _medicamen = medicineApi();
  //API DE DIETAS USUARIO
  dietaApi _dietas = dietaApi();
  //API DE RECETA USUARIO
  recetaMApi _receta = recetaMApi();

  final _key =  GlobalKey<FormState>();
  String cedula = '';
  String password = '';
  //int alarmID = 1;

  //MODEL CLASS PERSONA (TIPO INJECTION) - GET IT
  modelClass _modelClass = GetIt.instance.get<modelClass>();
  //MODEL CLASS MEDICMANETO (TIPO INJECTION) - GET IT
  modelClassMedica _modelMedicamto = GetIt.instance.get<modelClassMedica>();
  //MODEL CLASS DIETAS (TIPO INJECTION) - GET IT
  modelClassDieta _modelDieta = GetIt.instance.get<modelClassDieta>();
  //MODEL CLASS DIETAS (TIPO INJECTION) - GET IT
  modelClassReceta _modelReceta = GetIt.instance.get<modelClassReceta>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
           alignment: Alignment.center,
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
              gradient: RadialGradient(colors: [
            Color.fromRGBO(68, 138, 255, 0.15),
            Colors.white,
          ], center: Alignment.topRight, radius: 0.8)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _welcomeText(),
                _imagen(),
                 SizedBox(
                        height: size.height * 0.03,
                      ),
                _titulo(),
                 SizedBox(
                        height: size.height * 0.03,
                      ),
                _inputUsuario(),
                const Divider(
                  color: Colors.transparent,
                  height: 25.0,
                ),
                _inputPassword(),
                SizedBox(
                        height: size.height * 0.02,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Recuperar contraseña?',
                          style: GoogleFonts.inter(
                            fontSize: 13.0,
                            color: const Color(0xFF6A6F7D),
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                SizedBox(
                        height: size.height * 0.03,
                      ),
                _boton(context),
                      /*ElevatedButton(
                    onPressed: () async {
                      print('TOUCHEDDDD');

                      //print(' /// *** ${printHello().then((value) => print(" HY $value"))}');
                      await AndroidAlarmManager.oneShotAt(DateTime(2023,02,07,10,55),  Random().nextInt(pow(2, 31) as int), printHello, exact: true, wakeup: true, rescheduleOnReboot: true);
                     
                    },
                    child: const Text('Show Scheduled Notification'),
                  ),*/

              ],
            ),
          ),
        ),
      ),
    );
    /*return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 50),
        children: <Widget>[
          ElevatedButton(
                    onPressed: () async {
                      print('TOUCHEDDDD');

                      await AndroidAlarmManager.oneShotAt(DateTime(2022,09,24,23,57),  Random().nextInt(pow(2, 31) as int), printHello, exact: true, wakeup: true, rescheduleOnReboot: true);
                     
                    },
                    child: const Text('Show Scheduled Notification'),
                  ),


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
    );*/
    
  }
Widget _welcomeText() {
    return Center(
      child: Text.rich(
        TextSpan(
          style: GoogleFonts.inter(
            fontSize: 22.0,
            color: const Color.fromRGBO(46, 80, 140, 1.8),
            height: 1.59,
          ),
          children: const [
            TextSpan(
              text: '¡Bienvenido de nuevo!',
              style: TextStyle(fontWeight: FontWeight.bold)
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

 Widget _imagen() {
  return Container(
    margin: const EdgeInsets.fromLTRB(0, 50.0, 0, 0),
    child: const Image(
    image: AssetImage('assets/logoCMED.png'),
    //image: AssetImage('assets/heart.png'),
    color:Color.fromRGBO(71, 122, 213, 1),
    width: 200.0,
    height: 150.0,
    ),
  );
 }
 
Widget _titulo() {
  return Text.rich(
    TextSpan(
      style: GoogleFonts.inter(
          fontSize: 20,
          color: const Color.fromRGBO(71, 122, 213, 1),
          letterSpacing: 2.000000061035156,
        ),
        children: const [
          TextSpan(
            text: 'Iniciar',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          TextSpan(
            text: 'Sesión',
            style: TextStyle(
              color: Color.fromRGBO(46, 80, 140, 1.8),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
    )
  );

}

Widget _inputUsuario() {
  return TextField(
      key: const Key("inputUsuario"),
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
    key: const Key("inputPassword"),
      obscureText: passwordVisible,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: 'Escriba su contraseña',
        labelText: 'Contraseña',
        //helperText: 'Escriba solamente el password',
        suffixIcon: IconButton(
          icon: Icon(passwordVisible
          ? Icons.visibility_off
          : Icons.visibility),
          onPressed: () {
            setState(() {
              passwordVisible = !passwordVisible;
            });
          },
        )
      ),
      onChanged: (val) => setState(() => password = val),
    );
}

Widget _boton(BuildContext context) {
  return Container(
        alignment: Alignment.center,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          gradient: const LinearGradient(
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
                //PATRON SINGLETON USUARIO
                _modelClass.setValores(user);

                //PACIENTE CUENTA CON MEDICACION??
                var reqMedicine = await _medicamen.medicamento(user.cod_persona);
                if(reqMedicine.statusCode == 200 && reqMedicine.body.isNotEmpty){
                  // Tiene medicacion, tendra dieta y receta medica
                   //PATRON SINGLETON MEDICAMENTOS
                  _getMedicine(reqMedicine);
                  //PATRON SINGLETON DIETA
                  _getDietas(user.cod_persona);
                  //PATRON SINGLETON RECETA MEDICA
                  _getReceta(user.cod_persona);
                // ignore: use_build_context_synchronously
                  Navigator.push(context, PageTransition(
                    type: PageTransitionType.fade,
                    child: splashScreen(),
                    isIos: false,
                    duration: const Duration(milliseconds: 400)
                   ));
                }
                else{
                  // NO Cuenta con medicaicon activa
                  _modelMedicamto.setValoresNulos();
                   // ignore: use_build_context_synchronously
                  Navigator.push(context, PageTransition(
                    type: PageTransitionType.fade,
                    child: splashScreen(),
                    isIos: false,
                    duration: const Duration(milliseconds: 400)
                   ));
                }
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
            child: const Text('Ingresar al sistema'),
          ),
  );
}

_getMedicine(var reqM) async {
   //var req = await _medicamen.medicamento(codPersona);
   var medicamentos = ConsultaMedicamento.fromReqBody(reqM.body);
   //medicamentos.printAttributes();

  _modelMedicamto.setValores(medicamentos);

  //print(_modelMedicamto.medicamentos);
   
   
   
   /*String arrayObjsText = reqm.body;
   var medicamentos = jsonDecode(arrayObjsText)['receta_medica']['receta_medicamentos'] as List;
   List<Medicamento> listMedicam = medicamentos.map((medicamentoTag) => Medicamento.fromJson(medicamentoTag)).toList();
   print(listMedicam.length);*/
}

_getDietas(String codPersona) async {
  var req = await _dietas.dieta(codPersona);
  var dietasU = ConsultaDieta.fromReqBody(req.body);

  //dietasU.printAttributes();
  _modelDieta.setValores(dietasU);
}

_getReceta(String codPersona) async {
  var req = await _receta.receta(codPersona);
  var recetaME = ConsultaReceta.fromReqBody(req.body);

  recetaME.printAttributes();
  _modelReceta.setValores(recetaME);
}

// The background
  static SendPort? uiSendPort;

// The callback for our alarm
   static Future<int> printHello() async {
    print('INGRESNADO A CALLBACK');
    final instance = LocalNotificationService();
    instance.intialize();
    // Get the previous cached count and increment it.
    final prefs = await SharedPreferences.getInstance();
    final currentCount = prefs.getInt(countKey) ?? 0;
    await prefs.setInt(countKey, currentCount * 0 );
    
    // This will be null if we're running in the background.
    uiSendPort ??= IsolateNameServer.lookupPortByName(isolateName);
    uiSendPort?.send(null);
    
    //CANCELO TODAS LAS ALARMAS ANTERIORES PARA CREAR UAN NUEVA
    //instance.cancelAll();

   /* AuthApi _authAPI = AuthApi();
     var req = await _authAPI.login('1719624999', 'jhony123');
     var user = UserMob.fromReqBody(req.body);*/

    //SE CANCELA EL ALARM ID
    final now = DateTime.now();
    //await instance.showScheduledNotification(id: currentCount, title: currentCount.toString(), body: '2 capsulas', seconds: 5, scheduleDate: DateTime.parse('2022-03-03'));
    await instance.showScheduledNotification(id: currentCount, title: "Sumatriptán", body: '1 capsula', minutes: 15, scheduleDate: now);

    return currentCount;
    //await service.showScheduledNotification(id: 1, title: 'Hola SOY JHONY', body: 'APRENDI A USAR NOTIFICACIONES', seconds: 4);    
  }
}