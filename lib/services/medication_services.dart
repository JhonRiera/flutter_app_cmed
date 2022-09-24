import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../Models/medicineUser.dart';
import '../Models/modelClassMedica.dart';

modelClassMedica _modelMedicamto = GetIt.instance.get<modelClassMedica>();

class MyPill {

  bool band = false;
    DateTime fproximaToma = DateTime.now();
    //Obtengo el mes de la fecha actual 
    int formattedMounth = int.parse(DateFormat.M().format(DateTime.now()));
    //Obtengo el dia de la fecha actual
    int formattedDay = int.parse(DateFormat.d().format(DateTime.now()));
    //Obtengo la hora 
    int formattedHour = int.parse(DateFormat.H().format(DateTime.now()));
    //Obtengo el minuto
    int formattedMinute = int.parse(DateFormat.m().format(DateTime.now()));

  List<int> tomasCadaDiaHora = [0];
  int minuteStartMedication = 0;

  void GenerarTomasDiarias(int medicament){
    obtenerHorasDiaMedacion(medicament);
  }

  String proximaToma(int valor){
    //obtenerHorasDiaMedacion(valor);
      //print('TOMAS DIA $tomasCadaDiaHora');
      for(var data in tomasCadaDiaHora){
        if(formattedHour <= data && formattedMinute <= minuteStartMedication){
          //La siguiente toma esta en mismo dia, mes y anio 
          band = true;
          fproximaToma = DateTime(2022,formattedMounth,formattedDay, data, minuteStartMedication);
          break;
        }
      } 

      if(band!= true){
         fproximaToma = DateTime(2022,formattedMounth,formattedDay +1 , tomasCadaDiaHora.first, formattedMinute);
      }
      band = false;
      return DateFormat.MMMMEEEEd().format(fproximaToma);
  }
  
  DateTime obtFechaFinalMedicacion(int valor) {
    //fecha de inicio medicacion
    DateTime dateTime = DateTime.parse(_modelMedicamto.medicamentos.elementAt(valor).fechaCreacion);

    //fecha final de medicacion 
    return dateTime = dateTime.add(Duration(days: _modelMedicamto.medicamentos.elementAt(valor).dias));
  }
  
  void obtenerHorasDiaMedacion(int valor) {
    int addHour = 0;
    minuteStartMedication = int.parse(DateFormat.m().format(DateTime.parse(_modelMedicamto.medicamentos.elementAt(valor).fechaCreacion)));
    int frecuenciaEnHoras = _modelMedicamto.medicamentos.elementAt(valor).frecuencia;
    int horaInicio = int.parse(DateFormat.H().format(DateTime.parse(_modelMedicamto.medicamentos.elementAt(valor).fechaCreacion)));
    addHour = horaInicio;
    tomasCadaDiaHora.remove(0);

    while(addHour < 24){
      tomasCadaDiaHora.add(addHour);
      addHour = addHour + frecuenciaEnHoras;
    }

    while((addHour-24) < horaInicio){
      tomasCadaDiaHora.add(addHour-24);
      addHour = addHour + frecuenciaEnHoras;
    }

    tomasCadaDiaHora.sort();

    //print('TOMAS $tomasCadaDiaHora');
    //print(obtFechaFinalMedicacion(0));
  }

  String proximaTomaHora(int valor){
      for(var data in tomasCadaDiaHora){
        if(formattedHour <= data && formattedMinute <= minuteStartMedication){
          //La siguiente toma esta en mismo dia, mes y anio 
          band = true;
          fproximaToma = DateTime(2022,formattedMounth,formattedDay, data, minuteStartMedication);
          break;
        }
      } 

      if(band!= true){
         fproximaToma = DateTime(2022,formattedMounth,formattedDay +1 , tomasCadaDiaHora.first, minuteStartMedication);
      }
      band = false;
      return DateFormat.Hm().format(fproximaToma);
  }

  int totalVecesTomaMedicacion(int valor){
    int veces = 0;
    DateTime ffinal = obtFechaFinalMedicacion(valor);
    DateTime finicio = DateTime.parse(_modelMedicamto.medicamentos.elementAt(valor).fechaCreacion);
    
    
    while(finicio.compareTo(ffinal) < 0){
      veces = veces + tomasCadaDiaHora.length;
      finicio = finicio.add(const Duration(days: 1));
    }
    print('VCESE $veces');
    return veces;
  }

  double obtPorcentajeMedicacion(int medicamto){
    //obtenerHorasDiaMedacion(medicamto);
    int totTomas = totalVecesTomaMedicacion(medicamto);
    int tomasHastaHoy = 0;
    DateTime hoy = DateTime.now();
    DateTime finicio = DateTime.parse(_modelMedicamto.medicamentos.elementAt(medicamto).fechaCreacion);
  //compara por fecha 
  while(finicio.compareTo(hoy) < 0){
    tomasHastaHoy += tomasCadaDiaHora.length;
    finicio = finicio.add(const Duration(days: 1));
  }
   
  
  // REGLA DE TRES
  print('TT $tomasHastaHoy');
  return double.parse(((tomasHastaHoy*100)/totTomas).toStringAsFixed(1));

  }
  
}