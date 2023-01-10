import 'dart:io';
import 'package:cmed_app/Models/API/pdf_api.dart';
import 'package:cmed_app/Models/customer.dart';
import 'package:cmed_app/Models/invoice.dart';
import 'package:cmed_app/Models/modelClassDietas.dart';
import 'package:cmed_app/Models/modelClassRecetaM.dart';
import 'package:cmed_app/Models/receta.dart';
import 'package:cmed_app/Models/supplier.dart';
import 'package:cmed_app/utils.dart';
import 'package:get_it/get_it.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

modelClassReceta _modelReceta = GetIt.instance.get<modelClassReceta>();

class PdfRecetaApi {
  static Future<File> generate(Receta receta) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(receta),
        SizedBox(height: 3 * PdfPageFormat.cm),
        buildTitle(receta),
        //buildInvoice(invoice),
        Divider(),
        buildMedicamentos(receta),
        //buildTotal(invoice),
      ],
      footer: (context) => buildFooter(receta),
    ));

    return PdfApi.saveDocument(name: 'receta_CMED_movil.pdf', pdf: pdf);
  }

  static Widget buildHeader(Receta receta) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSupplierAddress(receta.supplier),
              Container(
                height: 50,
                width: 50,
                child: BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: receta.inforec.cod_persona,
                ),
              ),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildCustomerAddress(receta.customer),
              buildRecetaInfo(receta.inforec),
            ],
          ),
        ],
      );

  static Widget buildCustomerAddress(Customer customer) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(customer.name, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(customer.address),
        ],
      );

  static Widget buildRecetaInfo(RecetaInfo info) {
    //final paymentTerms = '${info.dueDate.difference(info.date).inDays} days';
    final titles = <String>[
      'Fecha Creación de Receta:',
      'Fecha Creación de dieta:',
      'Código del Paciente:',
    ];
    final data = <String>[
      Utils.formatDate(info.fechaCreacionR),
      Utils.formatDate(info.fechaCreacionD),
      //paymentTerms,
      info.cod_persona,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static Widget buildSupplierAddress(Supplier supplier) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(supplier.cedula, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(supplier.nombre),
          Text(supplier.email),
        ],
      );

  static Widget buildTitle(Receta receta) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RECETA-MEDICAMENTO',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Text(_modelReceta.descripcion),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildMedicamentos(Receta medicamento) {
    final headers = [
      'Código de receta médica',
      'Nombre del medicamento',
      'Dosis de consumo',
      'Frecuencia de toma de medicamento',
      'Fecha de prescripción',
    ];
    final data = medicamento.medicamentos.map((item) {
      //final total = item.unitPrice * item.quantity * (1 + item.vat);

      return [
        (item.cod_receta_medica),
        item.nombre_medicamento,
        item.dosis,
        item.frecuencia,
        Utils.formatDate(item.fecha_prescripcion),
        /*'${item.quantity}',
        '\$ ${item.unitPrice}',
        '${item.vat} %',
        '\$ ${total.toStringAsFixed(2)}',*/
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotal(Invoice invoice) {
    final netTotal = invoice.items
        .map((item) => item.unitPrice * item.quantity)
        .reduce((item1, item2) => item1 + item2);
    final vatPercent = invoice.items.first.vat;
    final vat = netTotal * vatPercent;
    final total = netTotal + vat;

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Total neto',
                  value: Utils.formatPrice(netTotal),
                  unite: true,
                ),
                buildText(
                  title: 'IVA ${vatPercent * 100} %',
                  value: Utils.formatPrice(vat),
                  unite: true,
                ),
                Divider(),
                buildText(
                  title: 'Monto Total',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  value: Utils.formatPrice(total),
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(Receta receta) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          pw.Text("Direccion: Av.Pedro Vicente Maldonado y Nicolás Singles"),
          //buildSimpleText(title: 'Dirección:', 'Av.Pedro Vicent'),
          SizedBox(height: 1 * PdfPageFormat.mm),
          pw.Text('Centro Médico de Especialidades "La Dolorosa"')
          //buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
