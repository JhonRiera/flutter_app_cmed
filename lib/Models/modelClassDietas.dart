import 'package:cmed_app/Models/consultaDieta.dart';

class modelClassDieta{
    String tpoDieta = '';
    String detalle = '';
    String feCreacion = '';

    setValores(ConsultaDieta vals){
      tpoDieta = vals.tpoDieta;
      detalle = vals.detalle;
      feCreacion = vals.feCreacion;
    }
}