import 'package:cmed_app/Models/customer.dart';
import 'package:cmed_app/Models/modelClassMedica.dart';
import 'package:cmed_app/Models/supplier.dart';
import 'package:get_it/get_it.dart';
modelClassMedica _modelMedicamto = GetIt.instance.get<modelClassMedica>();


class Receta {
  final RecetaInfo inforec;
  final Supplier supplier;
  final Customer customer;
  final List<Medicamentos> medicamentos;
  /*final InvoiceInfo info;
  final Supplier supplier;
  final Customer customer;
  final List<InvoiceItem> items;*/

  const Receta({
    required this.inforec,
    required this.supplier,
    required this.customer,
    required this.medicamentos,
    /*required this.info,
    required this.supplier,
    required this.customer,
    required this.items,*/
  });
}

class RecetaInfo {
  final DateTime fechaCreacionR;
  final DateTime fechaCreacionD;
  final String cod_persona;

  const RecetaInfo({
    required this.fechaCreacionR,
    required this.fechaCreacionD,
    required this.cod_persona
  });
}

class Medicamentos {
  final String cod_receta_medica;
  final String nombre_medicamento;
  final String dosis;
  final String frecuencia;
  final DateTime fecha_prescripcion;


  const Medicamentos({
    required this.cod_receta_medica,
    required this.nombre_medicamento,
    required this.dosis,
    required this.frecuencia,
    required this.fecha_prescripcion
  });
}
