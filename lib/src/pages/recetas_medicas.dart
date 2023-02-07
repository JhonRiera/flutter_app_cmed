import 'package:cmed_app/Models/API/pdf_api.dart';
import 'package:cmed_app/Models/API/pdf_invoice_api.dart';
import 'package:cmed_app/Models/API/pdf_receta_api.dart';
import 'package:cmed_app/Models/customer.dart';
import 'package:cmed_app/Models/invoice.dart';
import 'package:cmed_app/Models/modelClass.dart';
import 'package:cmed_app/Models/modelClassMedica.dart';
import 'package:cmed_app/Models/modelClassRecetaM.dart';
import 'package:cmed_app/Models/receta.dart';
import 'package:cmed_app/Models/supplier.dart';
import 'package:cmed_app/src/Widgets/button_widget.dart';
import 'package:cmed_app/src/Widgets/title_widget.dart';
import 'package:cmed_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

modelClassReceta _modelReceta = GetIt.instance.get<modelClassReceta>();
modelClass _modelClass = GetIt.instance.get<modelClass>();
modelClassMedica _modelMedicamto = GetIt.instance.get<modelClassMedica>();


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
            if(_modelMedicamto.cod_consulta != "empty")...[
                _paciente(),
                _titulo(),
                _fechaAtencion(),
                //_recetaMedica()
               _pdfRecetaMedica(),
            ]
            else...[
              const Divider(
                    color: Colors.transparent,
                    height: 95,
                  ),
              _sinMedicacion()
            ]
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
          Utils.formatDate(DateTime.parse(_modelReceta.fCreacion)),
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

  Widget _pdfRecetaMedica(){
    return Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const TitleWidget(
                  icon: Icons.picture_as_pdf,
                  text: 'Visualizar Receta Médica',
                ),
                const SizedBox(height: 48),
                ButtonWidget(
                  text: "Receta Médica PDF",
                  onClicked: () async {
                    //final date = DateTime.now();
                    //final dueDate = date.add(const Duration(days: 7));
                    final receta = Receta(
                      supplier: Supplier(
                        cedula: _modelClass.cedula,
                        nombre: _modelClass.nombre,
                        email: _modelClass.email,
                      ),
                      customer: const Customer(
                        name: 'CMED móvil',
                        address: 'Teléfono: (02) 269-2520, C.P. 170704',
                      ),
                      inforec: RecetaInfo(
                        fechaCreacionR: DateTime.parse(_modelReceta.fCreacion),
                        fechaCreacionD: DateTime.parse(_modelMedicamto.medicamentos.first.fechaCreacion),
                        cod_persona: _modelClass.cod_persona,
                        /*date: date,
                        dueDate: dueDate,
                        description: 'My description...',
                        number: '${DateTime.now().year}-9999',*/
                      ),
                      medicamentos: [
                        for(var medicamntos in _modelMedicamto.medicamentos)...[
                          Medicamentos(
                            cod_receta_medica: medicamntos.cod_receta_medica, 
                            nombre_medicamento: medicamntos.nombreMedicamento,
                            dosis: medicamntos.dosis, 
                            frecuencia: medicamntos.frecuencia.toString(), 
                            fecha_prescripcion: DateTime.parse( medicamntos.fechaCreacion) 
                            )
                        ]
                        /*InvoiceItem(
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
                        ),*/
                      ],
                    );

                    final pdfFile = await PdfRecetaApi.generate(receta);

                    PdfApi.openFile(pdfFile);
                  },
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

}