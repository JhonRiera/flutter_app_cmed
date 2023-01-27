// ignore_for_file: no_leading_underscores_for_local_identifiers, camel_case_types, unnecessary_const, avoid_unnecessary_containers, unused_local_variable, sized_box_for_whitespace, unrelated_type_equality_checks

import 'dart:convert';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:cmed_app/Models/API/dailyProgressApi.dart';
import 'package:cmed_app/Models/API/medicineApi.dart';
import 'package:cmed_app/Models/API/ultimoAceeso.dart';
import 'package:cmed_app/Models/alarmUser.dart';
import 'package:cmed_app/Models/medicineUser.dart';
import 'package:cmed_app/Models/consultaMedicamento.dart';
import 'package:cmed_app/Models/service_locator.dart';
import 'package:cmed_app/services/medication_services.dart';
import 'package:cmed_app/services/progress_pill_card.dart';
import 'package:cmed_app/src/pages/default_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/API/notification_api.dart';
import '../../Models/modelClass.dart';
import '../../Models/modelClassMedica.dart';
import '../../Models/modelProgress.dart';
import '../../main.dart';

modelClass _modelClass = GetIt.instance.get<modelClass>();
modelClassMedica _modelMedicamto = GetIt.instance.get<modelClassMedica>();

//TAMANIO DE LAS TARJETAS DE PROGRESO DIARIO
  final PageController _pageController =
      PageController(viewportFraction: 0.9, initialPage: 0);
  double _page = 0;
  
 //API PROGRESO DIARIO
 DailyProgress _dailyP = DailyProgress(); 

 //LISTADO DE LOS CARDS PPARA PILL
 // ignore: unnecessary_late
 late List<PillCard> _cardsPill = [];
 
typedef MedicineChangedCallback = Function(Medicamento medicina, bool touch);
class MedicineListItem extends StatelessWidget {
  final VoidCallback onPressed;

  MedicineListItem({
    required this.medicina,
    required this.touch,
    required this.onTouchChanged,
    required this.onPressed,
  }) : super(key: ObjectKey(medicina));

  final Medicamento medicina;
  final bool touch;
  final MedicineChangedCallback onTouchChanged;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.
    return touch //
        ? Colors.black54
        : Theme.of(context).primaryColor;
  }
  TextStyle? _getTextStyle(BuildContext context) {
    if (!touch) return null;

    return const TextStyle(
      color: Colors.black54,
      //decoration: TextDecoration.lineThrough,
    );
  }
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,/*() {
        onTouchChanged(medicina, touch);
      },*/
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(medicina.nombreMedicamento[0]),
      ),
     title: _getNameMedicine(context),
    );
  }

    Widget _getNameMedicine(BuildContext context){
    if(medicina.nombreMedicamento.length >= 20){
      return Text(medicina.nombreMedicamento.substring(0,20),
      style: _getTextStyle(context),);
    }
    else{
      return Text(medicina.nombreMedicamento,
      style: _getTextStyle(context),);
    }
  }
}


class homePage extends StatefulWidget {
  //const homePage({ super.key});
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  late Future<Progreso> futureProgreso;
  final List<Medicamento> medicamentos = [];
   final _shoppingCart = <Medicamento>{};
  //API actualizar ultimo acceso a la APP
  final ultimoAccesoApi _ultimoacc = ultimoAccesoApi();

@override
  void initState(){
    // ignore: todo
    // TODO: implement initState
    super.initState();
    futureProgreso = fetchData('','');
    //AL INICIAR SESION ACTUALIZO FECHA DE ULTIMO ACCESO
    actualizarFechaUltimoAcc();
     //_CrearNotificaciones();
     _pageController.addListener(() {
      if (_pageController.page != null) {
        _page = _pageController.page!;
      }
    });
  }

void _handleCartChanged(Medicamento medicina, bool touch) {
    setState(() {
      if (!touch) {
        _shoppingCart.add(medicina);
      } else {
        _shoppingCart.remove(medicina);
      }
    });
  }

void _showCard(String codMed){
  setState(() {
    futureProgreso = fetchData(codMed,'2023-01-17');
  });
}

  @override
  Widget build(BuildContext context) {  
    final size = MediaQuery.of(context).size;//SIZE DEL SIZEDBOX
    return Scaffold(
      body: ListView(
        children: <Widget>[
          if(_modelMedicamto.cod_consulta != "empty")...[
            _saludoTop(),
            _tituloEstado(),
            _circularProgress(),
            _titDietas(),
            SizedBox(
              height: size.height * 0.01,
            ),
            
            //TAREJTAS DE MEDICAMENTOS 
            for(var j in _modelMedicamto.medicamentos)...[
              Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                  child: MedicineListItem(
                  medicina: j, 
                  touch: _shoppingCart.contains(j), 
                  onTouchChanged: _handleCartChanged,
                  onPressed: () => _showCard(j.cod_receta_medica),
                  ),
                ),
                ],
              ),             
            ],
            /*CREANDO TARJETAS DE PROGRESO DIARIO */
            DefaultTextStyle(
                style: Theme.of(context).textTheme.displayMedium!,
                textAlign: TextAlign.center,
                child: FutureBuilder<Progreso>(
                future: futureProgreso, // a previously-obtained Future<String> or null
                builder: (BuildContext context, AsyncSnapshot<Progreso> snapshot) {
                List<Widget> children;
                  if (snapshot.hasData) {
                    fullCards(snapshot.data!.medicamento, snapshot.data!.dosis, snapshot.data!.alarmas);
                    children = <Widget>[
                      _cardsHPe(context),
                      _carrouselVis(),
                    ];
                  } else if (snapshot.hasError) {
                  children = <Widget>[
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          const Icon(
                            Icons.error_outline,
                            color: Colors.blue,
                            size: 20,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text('Seleccione un medicamento',
                            style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ];
                      } else {
                        children = const <Widget>[
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text('Espere por favor...', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                          ),
                        ];
                      }
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: children,
                        ),
                      );
                    },
                  ),
              )
          ]else...[//Pagina SIN MEDICACION ACTIVA
            _saludoTop(),
            const Divider(
              color: Colors.transparent,
              height: 95,
            ),
            _sinMedicacion(),
          ]
        ]
      )
    );
  }

// The background
  static SendPort? uiSendPort;

 static Future<int> getCacheValue() async {
    final instance = LocalNotificationService();
    instance.intialize();

     // Get the previous cached count and increment it.
    final prefs = await SharedPreferences.getInstance();
    final currentCount = prefs.getInt(countKey) ?? 0;
    await prefs.setInt(countKey, currentCount * 0);

    // This will be null if we're running in the background.
    uiSendPort ??= IsolateNameServer.lookupPortByName(isolateName);
    uiSendPort?.send(null);

    return currentCount;
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
                  if(_modelClass.sexo == 'M')...[
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/man_user.png'),
                    ),
                    const SizedBox(width: 15.0),
                  ]
                  else...[
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/w_user.png'),
                    ),
                    const SizedBox(width: 15.0),
                  ],
                  
                  
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Text(
                          "Bienvenid@ ${_modelClass.nombre}",
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
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.alarm,
                              color: Color.fromRGBO(134, 252, 169, 2),
                              size: 24.0,
                            ),
                            const VerticalDivider(
                              width: 5,
                            ),
                            Text(
                          "Notificaciones activas",
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                          ],
                        )
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
    MyPill pill = MyPill();
    pill.GenerarTomasDiarias(0);
    double percent = pill.obtPorcentajeMedicacion(0);
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
                    //"Próxima toma: Wednesday, January 11",
                    "Próxima toma: ${pill.proximaToma(0)}",
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
                     //"Hora: 15:20 ",
                    "Hora: ${pill.proximaTomaHora(0)}",
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
            "Mi progreso del día",
            style: GoogleFonts.montserrat(
              fontSize: 15,
              fontWeight: FontWeight.bold
            ),
          ),
          const Icon(
            Icons.history_edu,
            color: Color.fromRGBO(0, 65, 196, 1),
            size: 24.0
          ),
        ],
      ),
    ),
  );
  }
  
  
  //WIDGET DEVUELVE CONTENEDOR SIN MEDICACION
  Widget _sinMedicacion() {
    return Container(
      alignment: Alignment.center,
      child: Image.asset(
            "assets/Alert-pill.png",
            fit: BoxFit.cover,
      ),
    );
  }
  
  //METODO PARA CTUALIZAR FECHA DE ULTIMO ACCESO AL SISTEMA
  Future<void> actualizarFechaUltimoAcc() async {
    final dateActual = DateTime.now();
    var reqUA = await _ultimoacc.usuarioUltimoAcc(_modelClass.cod_persona, dateActual.toString());
  }
  
  // ignore: non_constant_identifier_names
  Future<void> _CrearNotificaciones() async {
    int notificaciones = await getCacheValue();
    int anio = 2012, mes = 1, dia = 1, diaMaximo = 0, index;  

    if(notificaciones == 0){
      List<int> myList = [];
      for(var medic in _modelMedicamto.medicamentos){
        myList.add(medic.dias);
      }
      diaMaximo =  myList.reduce(max);//Obtengo el dia maximo para creacion de oneShot
      index = myList.indexOf(diaMaximo);
      DateTime fechaMedicamtoLargo = DateTime.parse(_modelMedicamto.medicamentos[index].fechaCreacion);
        anio = int.parse(DateFormat.y().format(fechaMedicamtoLargo));
        mes = int.parse(DateFormat.M().format(fechaMedicamtoLargo));
        dia = int.parse(DateFormat.d().format(fechaMedicamtoLargo));

      for(var i = 0 ; i< diaMaximo; i ++){
        if( i == 0 ){
            //Crear Par ese dia las notificaciones Y oneShot para las 11.59
        }
        else{
          await AndroidAlarmManager.oneShotAt(DateTime(anio,mes,dia,11,59).add(Duration(days: i)),  Random().nextInt(pow(2, 31) as int), createNotification, exact: true, wakeup: true, rescheduleOnReboot: true);
        }
      }
    }
    else{//Usuario que ya tiene notificaciones locales creadas
      
    }
  }
  

  static Future<void> createNotification() async{

  }
}

class ItemBuilder extends StatelessWidget {
  const ItemBuilder({
    Key? key,
    required List<PillCard> items,
    required this.index,
  })  : _items = items,
        super(key: key);

  final List<PillCard> _items;
  final int index;

  @override
  Widget build(BuildContext context) {
    bool _buttonEnabled = _items[index].estadoBoton; // Variable de estado para controlar el estado del botón
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 9, vertical: 18),
      height: 175,
      //color: Colors.blue.shade200.withOpacity(0.15),
      decoration: BoxDecoration(
              border: Border.all(color: _items[index].color , width: .25),
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white),
      child: ListView(
        children: [ 
          const Center(
            child: Divider(
              color: Colors.transparent,
            ),
          ), 
          // ignore: prefer_const_constructors
          Center(
            child: const Icon(Icons.medication, color: Colors.black26 ),
          ),       
          Center(
            child: Text(
            "Medicamento",
            style: GoogleFonts.roboto(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),),
          Center(
            child: Text(
              _items[index].title,
              style: GoogleFonts.roboto(
                fontSize: 13,
              ),
            ),
          ),
          Center(
            child: Text(
              _items[index].subtitleOne,
              style: GoogleFonts.roboto(
                fontSize: 13,
              ),
            ),
          ),
          Center(
            child: Text(
              DateFormat.Hm().format(_items[index].hora),
              style: GoogleFonts.roboto(
                fontSize: 13,
              ),
            ),
          ),
           Center(
            child: Text(
              _items[index].codAlarma,
              style: GoogleFonts.roboto(
                fontSize: 13,
                color: Colors.white
              ),
            ),
          ),
          SizedBox( //<-- SEE HERE
          width: 25,
          height: 25,
          child: FittedBox( //<-- SEE HERE
            child: FloatingActionButton( //<-- SEE HERE
              backgroundColor: color(),
              enableFeedback: false,
              onPressed: _buttonEnabled ? () {
                print(_items[index].codAlarma);
              }: null,
              child: const Icon(
                Icons.check,
                size: 35,
                color: Colors.black,
                )       ,
              ),
            ),
          ),
        ],
      )
    );
  }

  Color color(){
    if(_items[index].estadoBoton != false ){
      return  const Color.fromRGBO(74, 223, 221, 1);
    }
    else{
      if(_items[index].estadoBoton == false && _items[index].color == Colors.green){
        return  Colors.green;
      }
      else{
        if(_items[index].estadoBoton == false && _items[index].color == Colors.blueAccent){
          return Colors.black12;
        }
        return Colors.redAccent;
      }
      
    }
  }
}


//CARDS IN FLUTTER HOMEPAGE
Widget _cardsHPe(BuildContext context){
  return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _cardsPill.length ~/ 2 + _cardsPill.length % 2,
                itemBuilder: (context, index) {
                  return SizedBox(
                    child: Row(
                      children: [
                        Expanded(
                            child:
                                ItemBuilder(items: _cardsPill, index: index * 2)),
                        Expanded(
                            child: index * 2 + 1 >= _cardsPill.length
                                ? const SizedBox()
                                : ItemBuilder(
                                items: _cardsPill, index: index * 2 + 1)),
                      ],
                    ),
                  );
                }),
            );
}


//VISUALIZADOR DE CARROUSEL INFERIOR
Widget _carrouselVis(){
  return  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 0; i < _cardsPill.length ~/ 2 + _cardsPill.length % 2; i++)
                    Container(
                      margin: const EdgeInsets.all(2),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey, width: 1.5),
                          color: _page - i > 1 || _page - i < -1
                              ? Colors.transparent
                              : _page - i > 0
                                  ? Colors.grey.withOpacity(1 - (_page - i))
                                  : Colors.grey.withOpacity(1 - (i - _page))),
                    )
                ],
              );
}

/*WIDGET CARDS*/


class PillCard extends StatelessWidget{
  final Color color;
  final String title;
  final String subtitleOne;
  final String codAlarma;
  final DateTime hora;
  final bool estadoBoton;
  const PillCard(
    {
      required this.color,
      required this.title,
      required this.subtitleOne,
      required this.codAlarma,
      required this.hora,
      required this.estadoBoton,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

//LENAR CARTAS
fullCards(String title, String subtitleOne, List<Alarma> alm){
  DateTime horaActual =  DateTime.now();
  DateTime horaRecordatorioLocal = DateTime.parse(alm.last.tiempo_recordatorio).toLocal().add(const Duration(hours: 5));


 /* print("-TR- ${alm.last.tiempo_recordatorio}");
  print("-HA- $horaActual");
  print(horaRecordatorioLocal);
  print(horaActual.isBefore(horaRecordatorioLocal));*/

  _cardsPill =[
    for(var dat in alm)...[
      //Antes 
      if(horaActual.isBefore(DateTime.parse(dat.tiempo_recordatorio).toLocal().add(Duration(hours: 5))))...[
        PillCard(color: Colors.blueAccent, title: title, subtitleOne: subtitleOne, codAlarma: dat.cod_alarma, hora: DateTime.parse(dat.tiempo_recordatorio), estadoBoton: false),
      ]else...[
        //DESPUES
        if(horaActual.isAfter(DateTime.parse(dat.tiempo_recordatorio).toLocal().add(Duration(hours: 5))) && horaActual.compareTo(DateTime.parse(dat.tiempo_recordatorio).toLocal().add(Duration(hours: 5)).add(const Duration(hours: 2))) > 0 && dat.estado == false)...[
          PillCard(color: Colors.red, title: title, subtitleOne: subtitleOne, codAlarma: dat.cod_alarma, hora: DateTime.parse(dat.tiempo_recordatorio), estadoBoton: false),
        ]else...[
          if(dat.estado == true)...[
            PillCard(color: Colors.green, title: title, subtitleOne: subtitleOne, codAlarma: dat.cod_alarma, hora: DateTime.parse(dat.tiempo_recordatorio), estadoBoton: false),
          ]else...[
            PillCard(color: Colors.blueAccent, title: title, subtitleOne: subtitleOne, codAlarma: dat.cod_alarma, hora: DateTime.parse(dat.tiempo_recordatorio), estadoBoton: true),
          ]
        ]
      ]
      /*if(horaActual.compareTo(DateTime.parse(dat.tiempo_recordatorio).add(Duration(hours: 2))) < 0 )...[
          //Antes de dos horas de la hora que tenia que tomar el medicamento
        PillCard(color: Colors.blueAccent, title: title, subtitleOne: subtitleOne, codAlarma: dat.cod_alarma, hora: DateTime.parse(dat.tiempo_recordatorio), estadoBoton: true),
      ]
      else ...[
       PillCard(color: Colors.red, title: title, subtitleOne: subtitleOne, codAlarma: dat.cod_alarma, hora: DateTime.parse(dat.tiempo_recordatorio), estadoBoton: false),

      ]*/
    ]
  ];

}

//FutureBuilder Progreso
Future<Progreso> fetchData(String cod, String date) async {
  var response = await _dailyP.dailyProgss(cod,date);
  if(response.statusCode == 200){
    var p = Progreso.fromReqBody(response.body);
    //p.printAttributes(); 
    return Progreso.fromReqBody(response.body);
  }
  else{
    throw Exception('Failed to load data');
  }
}