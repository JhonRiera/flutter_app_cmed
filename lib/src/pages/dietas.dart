import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Models/modelClass.dart';

modelClass _modelClass = GetIt.instance.get<modelClass>();

class dietasPage extends StatelessWidget {
  const dietasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(0, 65, 196, 1),
        title:  Text("Mis Dietas",
          style: GoogleFonts.cabin(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center)
        ),
      body: ListView(
        children: <Widget>[
          //_titulo(),
          //_imagen(),
          _paciente(),
          _dietas(),
          _estado(),
          _visualizarDieta()
        ],
      ),
    );
  }
  
 /* Widget _titulo() {
    return Container(
    margin: const EdgeInsets.all(10),
    decoration: const BoxDecoration(color: Colors.white),
    child: Padding(
      padding: const EdgeInsets.only(left: 25.0, top: 20, right: 25, bottom: 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Mis Dietas",
            style: GoogleFonts.cabin(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
  }
  
  Widget _imagen() {
    return Container(
    margin: const EdgeInsets.all(10),
    decoration: const BoxDecoration(color: Colors.white),
    child: Padding(
      padding: const EdgeInsets.only(left: 25.0, top: 5, right: 25, bottom: 10),
      child: Column(
        children: const <Widget>[
          Image(
              image: AssetImage('assets/dieta-1.png'),
              height: 100.0 
          )
        ],
      ),
    ),
  );
  }*/
  
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
  
  Widget _dietas() {
    return Container(
    //margin: const EdgeInsets.all(10),
    decoration: const BoxDecoration(color: Colors.white),
    child: Padding(
      padding: const EdgeInsets.only(left: 25.0, top: 1, right: 25, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Card(
          elevation: 8,
          margin: const EdgeInsets.all(10),
          child: Container(
            height: 100,
            color: Colors.white,
            child: Row(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Expanded(
                      flex:2 ,
                      child:Image.asset("assets/dieta.png"),
                    ),
                  ),
                ),
                Expanded(
                  flex:8 ,
                  child:Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: ListTile(
                            title: Text("Dieta Blanda"),
                            subtitle: Text("Consumo hasta: 2022/09/12"),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                child:const Text("VER"),
                                onPressed: ()
                                {},
                              ),
                              const SizedBox(width: 8,)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ],
      ),
    ),
  );
  }
  
  Widget _visualizarDieta() {
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
              title: Text('Leche y otros productos lácteos, solo bajos en grasa o sin grasa, Verduras cocidas, enlatadas o congeladas, Jugos de frutas y de verduras (algunas personas, especialmente aquellas con ERGE, es posible que quieran evitar los cítricos y los tomates Panes, galletas y pasta elaborados con harina blanca refinadaPanes, galletas y pasta elaborados con harina blanca refinada, Carnes tiernas y magras, tales como las de aves de corral, el pescado blanco y los mariscos, preparados al vapor, horneados o asados a la parrilla sin grasa agregada',
              textAlign: TextAlign.justify,),  
            ),  
            
            ],
          )
        );
  }
  
  Widget _estado() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, bottom: 10),
      child: Row(
      children: <Widget>[
        const Icon(Icons.food_bank, color: Color.fromRGBO(0, 65, 196, 1)),
        Text(
          "Visualizando: Dieta Blanda",
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.bold
          ),
        ),
      ],
    ),
    );
  }
}