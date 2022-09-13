// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:cmed_app/Models/API/medicineApi.dart';
import 'package:cmed_app/Models/medicineUser.dart';
import 'package:cmed_app/Models/consultaMedicamento.dart';
import 'package:cmed_app/Models/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../Models/modelClass.dart';
import '../../Models/modelClassMedica.dart';

modelClass _modelClass = GetIt.instance.get<modelClass>();
modelClassMedica _modelMedicamto = GetIt.instance.get<modelClassMedica>();


class homePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          _saludoTop(),
          _tituloEstado(),
          _circularProgress(),
          _titDietas(),
          _cardDietas()
        ]
      )
    );
  }
  
  Widget _saludoTop() {
    String _fecha = _modelClass.fecha_ult_acceso;
    DateTime? datetime = DateTime.tryParse(_fecha);
    
    String formattedDate = DateFormat.yMMMd().format(datetime!);

    return Container(
      padding: const EdgeInsets.all(25.0),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(0, 65, 196, 1),
        borderRadius: BorderRadius.only(
           bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0))),
      child: Column(
        children: <Widget>[
          Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: <Widget>[
              Row(
                children: <Widget>[
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/man_user.png'),
                  ),
                  const SizedBox(width: 15.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Text(
                          "Bienvenido ${_modelClass.nombre}",
                          style: GoogleFonts.montserrat(
                              fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Último Ingreso: $formattedDate",
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                    ],
                  ),
                ],
              )
             ],
          )
        ],
      ),
      );
  }
  
 Widget _tituloEstado() {
  
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
      padding: const EdgeInsets.only(left: 25.0, top: 20, right: 25, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Progreso de medicación",
            style: GoogleFonts.montserrat(
              fontSize: 15,
              fontWeight: FontWeight.bold
            ),
          ),
          const Icon(
            Icons.medication,
            color: Color.fromRGBO(0, 65, 196, 1),
            size: 24.0
          ),
        ],
      ),
    ),
  );
 }
 
  Widget _circularProgress() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            CircularPercentIndicator(
                radius: 70.0,
                animation: true,
                animationDuration: 1300,
                lineWidth: 25.0,
                percent: 0.4,
                center: Text(
                  '40%',
                  style: GoogleFonts.montserrat(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                 circularStrokeCap: CircularStrokeCap.butt,
                 backgroundColor: const Color.fromRGBO(204, 204, 204, 1),
                 progressColor: Colors.blueAccent,
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  width: 160.0,
                  child: Text(
                      _modelMedicamto.medicamentos.first.nombreMedicamento,
                      style: GoogleFonts.roboto(
                      fontSize: 17,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                   ),
                   textAlign: TextAlign.left,
                   ),
                ),
                const Divider(
                    color: Colors.transparent,
                    height: 10.0,
                ),
                SizedBox(
                  width: 160.0,
                  child: Text(
                    "Próxima toma: Lun 25 Nov",
                    style: GoogleFonts.roboto(
                    fontSize: 13.5,
                  ),
                  textAlign: TextAlign.left,
                  ),
                ),
                const Divider(
                    color: Colors.transparent,
                    height: 5.0,
                ),
                SizedBox(
                  width: 160.0,
                  child: Text(
                    "Hora: 15:25",
                    style: GoogleFonts.roboto(
                    fontSize: 13.5,
                  ),
                  textAlign: TextAlign.left,
                  ),
                ),
                const Divider(
                    color: Colors.transparent,
                    height: 5.0,
                ),
                SizedBox(
                  width: 160.0,
                  child: Text(
                    "Dosis: ${_modelMedicamto.medicamentos.first.dosis}",
                    style: GoogleFonts.roboto(
                    fontSize: 13.5,
                  ),
                  textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _titDietas() {
    return Container(
    margin: const EdgeInsets.fromLTRB(20, 20, 20, 2),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.05),
        spreadRadius: 4,
        blurRadius: 7,
        offset: const Offset(0,4)
      )
    ]),
    child: Padding(
      padding: const EdgeInsets.only(left: 25.0, top: 20, right: 25, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Dietas",
            style: GoogleFonts.montserrat(
              fontSize: 15,
              fontWeight: FontWeight.bold
            ),
          ),
          const Icon(
            Icons.restaurant_menu,
            color: Color.fromRGBO(0, 65, 196, 1),
            size: 24.0
          ),
        ],
      ),
    ),
  );
  }
  
  Widget _cardDietas() {
    return Container(
      margin: const EdgeInsets.all(0.005),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 10),
        child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            //margin: const EdgeInsets.all(0),
            elevation: 1,
            child: Column(
              children: const <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.fromLTRB(15, 5, 25, 0),
                  title: Text('Dieta Blanda'),
                  subtitle: Text(
                    'Alimentos suaves, poca fibra'),
                    leading: Icon(Icons.apple)
                    ),
                    ],
                    ),
                    )
      ),
    );
  }
}