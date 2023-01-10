import 'package:cmed_app/Models/modelClass.dart';
import 'package:cmed_app/Models/modelClassMedica.dart';
import 'package:cmed_app/services/medication_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../Models/medicineUser.dart';

modelClassMedica _modelMedicamto = GetIt.instance.get<modelClassMedica>();
modelClass _modelClass = GetIt.instance.get<modelClass>();

class medicamentosPage extends StatefulWidget {
  medicamentosPage({Key? key}) : super(key: key);

  @override
  State<medicamentosPage> createState() => _medicamentosPageState();
}

class _medicamentosPageState extends State<medicamentosPage> {
  
  List<DateTimeRange> dateTimeRanges = [
  
];

  @override
  Widget build(BuildContext context) {
    _llenarFechas();
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
          for(var i = 0; i<_modelMedicamto.medicamentos.length; i++)...[
            _circularProgress(_modelMedicamto.medicamentos[i], i)
          ]
        ],
      ),
    );
  }
  

  Widget _circularProgress(Medicamento pro, int i) {
    MyPill pill = MyPill();
    pill.GenerarTomasDiarias(i);
    double percent = pill.obtPorcentajeMedicacion(i);
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
                percent: (percent/100),
                center: Text(
                  '$percent%',
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
                      pro.nombreMedicamento,
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
                    "Próxima toma: ${pill.proximaToma(i)}",
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
                    "Hora: ${pill.proximaTomaHora(i)}",
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
                    "Dosis: ${pro.dosis}",
                    style: GoogleFonts.roboto(
                    fontSize: 13.5,
                  ),
                  textAlign: TextAlign.left,
                  ),
                ),
                 InkWell(
                    child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                     padding: const EdgeInsets.all(0.0),
                     child: new IconButton(
                     icon: new Icon(Icons.calendar_month, color: Colors.black54,),
                     iconSize: 25.0,
                      onPressed: () => pickDateRange(i),
                      ),
                 ))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future pickDateRange(int i) async {
  final range = await showDateRangePicker(
    context: context,
    initialDateRange: dateTimeRanges[i],
    firstDate: DateTime(1900), 
    lastDate: DateTime(2100),
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
            _modelClass.nombre,
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
 
void _llenarFechas() {
  for(var mdcamntos in _modelMedicamto.medicamentos){
      /*dateTimeRanges = [
      DateTimeRange(start: DateTime.parse(mdcamntos.fechaCreacion), end: DateTime.parse(mdcamntos.fechaCreacion).add(Duration(days: mdcamntos.dias) )),
      //DateTimeRange(start: DateTime(2022, 02, 01), end: DateTime(2022, 02, 15)),
      //DateTimeRange(start: DateTime(2022, 03, 01), end: DateTime(2022, 03, 15)),
    ];*/
    dateTimeRanges.add( DateTimeRange(start: DateTime.parse(mdcamntos.fechaCreacion), end: DateTime.parse(mdcamntos.fechaCreacion).add(Duration(days: mdcamntos.dias) )));
  }
}
 


}

