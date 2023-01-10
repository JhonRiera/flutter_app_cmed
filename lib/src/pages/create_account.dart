import 'package:cmed_app/Models/API/cedulaPersona.dart';
import 'package:cmed_app/Models/getPersonCedula.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

CedulaPersona _apipc = CedulaPersona();
  late Future<getPersonCedula> futurePersona; 

class createAcountPage extends StatefulWidget {
  createAcountPage({Key? key}) : super(key: key);

  @override
  State<createAcountPage> createState() => _createAcountPageState();
}

class _createAcountPageState extends State<createAcountPage> {
  bool _visible = false;
  bool hayDatos = false;
  bool _btnLlenarF = false;
  bool state_inputs = false;
  late String cedula;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futurePersona = fetchData('');
  }

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
            _labelestado(context),
            const Divider(
            color: Colors.transparent,
            height: 20.0,
          ),
            _btnLlenarFormulario(),
            _inputEmail(),
            _inputPassword(),
            _inputConfiPassword(),
            const Divider(
            color: Colors.transparent,
            height: 30.0,
          ),
          Visibility(
            // ignore: sort_child_properties_last
            child: _btnRegistrase(),
            maintainSize: true, 
            maintainAnimation: true,
            maintainState: true,
            visible: _btnLlenarF, 
          ),
          //_btnRegistrase()
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
        suffixIcon: SizedBox(
          width: 1.0,
          height: 1.0,
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                futurePersona = fetchData(cedula);
                _visible = true;
              });
            },
            child: const Icon(
              Icons.search,
              size: 20.0,
            ),
          ),
        )
      ),
      onChanged: (cedul) => setState(() => cedula = cedul)
    );
}

Widget _labelestado(BuildContext context) {
  return FutureBuilder<getPersonCedula>(
    future: futurePersona,
    builder: (context, snapshot){
       if (snapshot.hasData) {
        hayDatos = true;
         return 
         Visibility(
              // ignore: sort_child_properties_last
              child: Center(
              child: Text(
              'Hola ${snapshot.data!.nombres}!!',
              style: GoogleFonts.montserrat(
                fontSize: 15,
                fontStyle: FontStyle.italic
                ),
                )
              ),
              maintainSize: true, 
              maintainAnimation: true,
              maintainState: true,
              visible: _visible, 
        );;
         //Text("Hola ${snapshot.data!.nombres} !!");
        } else if (snapshot.hasError) {
          return 
          Visibility(
              // ignore: sort_child_properties_last
              child: Center(
              child: Text(
              'Usuario no cuenta con historia clínica en CMED',
              style: GoogleFonts.montserrat(
                fontSize: 15,
                fontStyle: FontStyle.italic
                ),
                )
              ),
              maintainSize: true, 
              maintainAnimation: true,
              maintainState: true,
              visible: _visible, 
        );;
          
        }    // Por defecto, muestra un loading spinner
        return Visibility(
              // ignore: sort_child_properties_last
              child: Center(
              child: Text(
              ' !',
              style: GoogleFonts.montserrat(
                fontSize: 15,
                fontStyle: FontStyle.italic
                ),
                )
              ),
              maintainSize: true, 
              maintainAnimation: true,
              maintainState: true,
              visible: _visible, 
        );;
    }
  );
  /*return Visibility(
    // ignore: sort_child_properties_last
    child: Center(
    child: Text(
    'Hola Jhony!',
    style: GoogleFonts.montserrat(
      fontSize: 15,
      fontStyle: FontStyle.italic
      ),
      )
    ),
    maintainSize: true, 
    maintainAnimation: true,
    maintainState: true,
    visible: _visible, 
  ); */
}

Widget _inputEmail() {
  return Center(
    child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: const UnderlineInputBorder(),
              labelText: 'Email',
              enabled: state_inputs,
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
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Contraseña',
              enabled: state_inputs,
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
            decoration:InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Confirmar Contraseña',
              enabled: state_inputs,
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
          onPressed: () {
            setState(() {
              futurePersona = fetchData(cedula);
              _visible = true;
            });
          },
            child: const Text('Registrarme'),
          ),
  );
 }
 
 Widget _btnLlenarFormulario() {
  return FloatingActionButton.extended(
  label: Text('Llenar formulario'), // <-- Text
  backgroundColor: Colors.black,
  icon: Icon( // <-- Icon
    Icons.pending,
    size: 24.0,
  ),
  onPressed: () {
    if(hayDatos != false){
      setState(() {
        state_inputs = true;
        _btnLlenarF = true;
      });
    }
  },
);
 }

}
Future<getPersonCedula> fetchData(String cedula) async{

  var response = await _apipc.cedulaPersona(cedula);

  if(response.statusCode == 200){
    return getPersonCedula.fromReqBody(response.body);
  }
  else{
    throw Exception('Sin carga de datos cedula');
  }
}