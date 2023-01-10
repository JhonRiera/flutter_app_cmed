import 'package:cmed_app/Models/API/pdf_api.dart';
import 'package:cmed_app/Models/API/pdf_invoice_api.dart';
import 'package:cmed_app/Models/customer.dart';
import 'package:cmed_app/Models/invoice.dart';
import 'package:cmed_app/Models/modelClassDietas.dart';
import 'package:cmed_app/Models/modelClassRecetaM.dart';
import 'package:cmed_app/Models/supplier.dart';
import 'package:cmed_app/src/Widgets/button_widget.dart';
import 'package:cmed_app/src/Widgets/title_widget.dart';
import 'package:cmed_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../Models/modelClass.dart';

modelClass _modelClass = GetIt.instance.get<modelClass>();
modelClassDieta _modelDieta = GetIt.instance.get<modelClassDieta>();
modelClassReceta _modelReceta = GetIt.instance.get<modelClassReceta>();


class dietasPDF extends StatefulWidget {
  dietasPDF({Key? key}) : super(key: key);

  @override
  State<dietasPDF> createState() => _dietasPDFState();
}

class _dietasPDFState extends State<dietasPDF> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(0, 65, 196, 1),
          automaticallyImplyLeading: false,
          title: Text(_modelClass.nombre),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //_dietas(),
                const TitleWidget(
                  icon: Icons.picture_as_pdf,
                  text: 'Visualizar Dieta',
                ),
                const SizedBox(height: 48),
                ButtonWidget(
                  text: _modelDieta.tpoDieta,
                  onClicked: () async {
                    final date = DateTime.now();
                    final dueDate = date.add(const Duration(days: 7));
                    final invoice = Invoice(
                      supplier: Supplier(
                        cedula: _modelClass.cedula,
                        nombre: _modelClass.nombre,
                        email: _modelClass.email,
                      ),
                      customer: const Customer(
                        name: 'Apple Inc.',
                        address: 'Apple Street, Cupertino, CA 95014',
                      ),
                      info: InvoiceInfo(
                        fechaCreacionR: DateTime.parse(_modelDieta.feCreacion),
                        fechaCreacionD: DateTime.parse(_modelReceta.fCreacion),
                        cod_persona: _modelClass.cod_persona,
                        /*date: date,
                        dueDate: dueDate,
                        description: 'My description...',
                        number: '${DateTime.now().year}-9999',*/
                      ),
                      items: [
                        InvoiceItem(
                          description: 'Coffee',
                          date: DateTime.now(),
                          quantity: 3,
                          vat: 0.19,
                          unitPrice: 5.99,
                        ),
                        InvoiceItem(
                          description: 'Water',
                          date: DateTime.now(),
                          quantity: 8,
                          vat: 0.19,
                          unitPrice: 0.99,
                        ),
                        InvoiceItem(
                          description: 'Orange',
                          date: DateTime.now(),
                          quantity: 3,
                          vat: 0.19,
                          unitPrice: 2.99,
                        ),
                        InvoiceItem(
                          description: 'Apple',
                          date: DateTime.now(),
                          quantity: 8,
                          vat: 0.19,
                          unitPrice: 3.99,
                        ),
                        InvoiceItem(
                          description: 'Mango',
                          date: DateTime.now(),
                          quantity: 1,
                          vat: 0.19,
                          unitPrice: 1.59,
                        ),
                        InvoiceItem(
                          description: 'Blue Berries',
                          date: DateTime.now(),
                          quantity: 5,
                          vat: 0.19,
                          unitPrice: 0.99,
                        ),
                        InvoiceItem(
                          description: 'Lemon',
                          date: DateTime.now(),
                          quantity: 4,
                          vat: 0.19,
                          unitPrice: 1.29,
                        ),
                      ],
                    );

                    final pdfFile = await PdfInvoiceApi.generate(invoice);

                    PdfApi.openFile(pdfFile);
                  },
                ),
              ],
            ),
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

/* ENDF OF PDF*/
/*class dietasPage extends StatelessWidget {
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
  }*/
  
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
}*/