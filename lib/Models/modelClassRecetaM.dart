import 'package:cmed_app/Models/consultaReceta.dart';

class modelClassReceta{
  String descripcion = '';
  String fCreacion = '';

  setValores(ConsultaReceta vals){
    descripcion = vals.descripcion;
    fCreacion = vals.fCreacion;
  }
}