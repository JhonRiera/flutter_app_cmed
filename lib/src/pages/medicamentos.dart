import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class medicamentosPage extends StatelessWidget {
  const medicamentosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(0, 65, 196, 1),
        title:  Text("Mis Medicamentos",
          style: GoogleFonts.cabin(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center)
      ),
      body: ListView(
        children: <Widget>[
          _paciente(),
          _tituloEstado(),
          _ciularProgress(),
          _secondProgress()
        ],
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
      padding: const EdgeInsets.only(left: 25.0, top: 10, right: 25, bottom: 10),
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
 
  Widget _ciularProgress() {
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
                      "Omeprazol 500gr",
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
                    "Dosis: 2 Capsulas",
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
  
 Widget _secondProgress() {
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
                percent: 0.75,
                center: Text(
                  '75%',
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
                      " Simvastatina",
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
                    "Próxima toma: Mie 25 Agosto",
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
                    "Hora: 17:00",
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
                    "Dosis: 1 Capsulas",
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
}