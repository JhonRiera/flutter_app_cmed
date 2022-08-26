import 'package:cmed_app/src/pages/create_account.dart';
import 'package:cmed_app/src/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';


// ignore: camel_case_types
class principalPage extends StatelessWidget {
  
  const principalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color.fromRGBO(0, 65, 196, 1),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: <Widget>[
          _logo(),
          _Bienvenida(),
          _titulo(),
          _btnLogueo(context),
          _BtnCreaCuenta(context),
        ],
      )
    );
  }
  
Widget _logo() {
    return const Image(image: AssetImage('assets/medication.png'), width: 380, height: 380);
  }
// ignore: non_constant_identifier_names
Widget  _Bienvenida() {
  return RichText(text: TextSpan(
    text: 'Bienvenido',
    style: GoogleFonts.cabin(
       fontSize: 40,
      fontWeight: FontWeight.bold
    )
  ));
}
   
Widget _titulo() {
    return Container(
      margin: const EdgeInsets.fromLTRB(1, 10, 0, 0),
      child: Text("CMED Movil", style: GoogleFonts.manrope(
        fontSize: 20, 
        color:  Colors.white
      ),),
    );
  }

 Widget _btnLogueo(BuildContext context) {
  return Container(
    margin: const EdgeInsets.fromLTRB(1, 30, 0, 0),
    child: ElevatedButton(
    onPressed: () {
      print('TOCADOO');
      Navigator.push(context, PageTransition(
        type: PageTransitionType.fade,
        child: loginPage(),
        isIos: false,
        duration: const Duration(milliseconds: 400),
      ));
    },
    style: TextButton.styleFrom(
      textStyle: const TextStyle(color: Color.fromRGBO(0, 65, 196, 1)),
              backgroundColor: Colors.white,
              shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
            )
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 100.5, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
           const Icon(
            Icons.login,
            color: Color.fromRGBO(0, 65, 196, 1),
            size: 25.0,
          ),
          Text(
            'Iniciar Sesión',
            style: GoogleFonts.openSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: const Color.fromRGBO(0, 65, 196, 1)),
            ),
        ],
      ),
    ),
  ),
  );
 }
  
// ignore: non_constant_identifier_names
Widget _BtnCreaCuenta(BuildContext context) {
  return Container(
    margin: const EdgeInsets.fromLTRB(1, 15, 0, 0),
    child: ElevatedButton(
    onPressed: () {
      Navigator.push(context, PageTransition(
        type: PageTransitionType.fade,
        child: createAcountPage(),
        isIos: false,
        duration: const Duration(milliseconds: 400)
      ));
    },
    style: TextButton.styleFrom(
      side: const BorderSide(width: 1.0, color: Colors.white),
      textStyle: const TextStyle(color: Colors.white),
              backgroundColor: const Color.fromRGBO(0, 65, 196, 1),
              shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
            )
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(115, 15, 0, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Crear cuenta',
            style: GoogleFonts.openSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
        ],
      ),
    ),
  ),
  );
}
}