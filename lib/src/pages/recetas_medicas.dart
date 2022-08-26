import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class recetaMPage extends StatelessWidget {
  const recetaMPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(0, 65, 196, 1),
        title:  Text("Mi Receta Médica",
          style: GoogleFonts.cabin(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center)
        ),
        body: ListView(
          children: [
            _paciente(),
            _titulo(),
            _fechaAtencion(),
            _recetaMedica()
          ],
        ),
      ),
    );
  }
  
  Widget _paciente() {
    return Container(
    decoration: const BoxDecoration(color: Colors.white),
    child: Padding(
      padding: const EdgeInsets.only(left: 25.0, top: 20, right: 25, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Paciente",
            style: GoogleFonts.montserrat(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "Jhony Riera",
            style: GoogleFonts.montserrat(
              fontSize: 13.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
  }
  
  Widget _titulo() {
    return Container(
    margin: const EdgeInsets.all(20),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        spreadRadius: 4,
        blurRadius: 7,
        offset: const Offset(0,5)
      )
    ]),
    child: Padding(
      padding: const EdgeInsets.only(left: 25.0, top: 10, right: 25, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Fecha de atención",
            style: GoogleFonts.montserrat(
              fontSize: 15,
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    ),
  );
  }
  
  Widget _fechaAtencion() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, bottom: 10, right: 10.0),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Icon(Icons.date_range, color: Color.fromRGBO(0, 65, 196, 1), size: 30,),
        Text(
          "22/07/2022",
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.bold
          ),
        ),
      ],
    ),
    );
  }
  
  Widget _recetaMedica() {
    return Container(
          height: 235,
          width: double.infinity,
          decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(20), color: Colors.white,
             border: Border.all(color: Colors.grey)
          ),
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: const <Widget>[
              ListTile(  
              title: Text('Diagnóstico: Cefalea tensional recurrente. Medicamento(s): Doloneurobion- Forte Teme 1 Capsula cada 12 horas por 15 días. Sustancia activa: Diclofenaco/Tiamina/Piridoxina/Cianocobalamina. Indicaciones: Evitar tensiones, situaciones de estrés, y descansar seguido. ',
              textAlign: TextAlign.justify,),  
            ),  
            
            ],
          )
        );
  }
}