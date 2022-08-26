import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class createAcountPage extends StatefulWidget {
  createAcountPage({Key? key}) : super(key: key);

  @override
  State<createAcountPage> createState() => _createAcountPageState();
}

class _createAcountPageState extends State<createAcountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
         padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 30),
          children: <Widget>[
            _icono(),
             const Divider(
            color: Colors.transparent,
            height: 10.0,
          ),
          _titulo(),
          const Divider(
            color: Colors.transparent,
            height: 10.0,
          ),
            _inputCedula(),
            const Divider(
            color: Colors.transparent,
            height: 20.0,
          ),
            _labelestado(),
            _inputEmail(),
            _inputPassword(),
            _inputConfiPassword(),
            const Divider(
            color: Colors.transparent,
            height: 30.0,
          ),
            _btnRegistrase()
          ],
        ),
      );
  }
  
Widget _icono() {
  return Container(
    margin: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
    child: const Image(
    image: AssetImage('assets/user.png'),
    color: const Color.fromRGBO(71, 122, 213, 1),
    width: 200.0,
    height: 150.0,
    ),
  );
}

Widget _inputCedula() {
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
    );
}

Widget _labelestado() {
  return Center(
    child: Text(
    'Hola Jhony!',
    style: GoogleFonts.montserrat(
      fontSize: 15,
      fontStyle: FontStyle.italic
    ),
    )
  );
}

Widget _inputEmail() {
  return Center(
    child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Email',
            ),
          ),
        ),
  );
}

Widget _inputPassword() {
  return Center(
    child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Contraseña',
            ),
          ),
        ),
  );
}
  
Widget _inputConfiPassword() {
  return Center(
    child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Confirmar Contraseña',
            ),
          ),
        ),
  );
}

Widget _titulo() {
  return Center(
    child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: RichText(text: TextSpan(
          text: 'Registrarse',
          style: GoogleFonts.cabin(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: const Color.fromRGBO(71, 122, 213, 1)
          ))
          )
        ),
  );
}

 Widget _btnRegistrase() {
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
          onPressed: () {},
            child: const Text('Registrarme'),
          ),
  );
 }


}