// ignore_for_file: non_constant_identifier_names

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
      for(var data in tomasCadaDiaHora){
        if(formattedHour <= data /*&& formattedMinute <= minuteStartMedication*/){
          //La siguiente toma esta en mismo dia, mes y anio 
          band = true;
          print('TRUEE');
          fproximaToma = DateTime(2023,formattedMounth,formattedDay, data, minuteStartMedication);
          break;
        }
      } 

      if(band!= true){
                  print('FALSEE');

         fproximaToma = DateTime(2023,formattedMounth,formattedDay +1 , tomasCadaDiaHora.first, formattedMinute);
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
  }

  String proximaTomaHora(int valor){
      for(var data in tomasCadaDiaHora){
        if(formattedHour <= data /*&& formattedMinute <= minuteStartMedication*/){
          //La siguiente toma esta en mismo dia, mes y anio 
          band = true;
          fproximaToma = DateTime(2023,formattedMounth,formattedDay, data, minuteStartMedication);
          break;
        }
      } 

      if(band!= true){
         fproximaToma = DateTime(2023,formattedMounth,formattedDay +1 , tomasCadaDiaHora.first, minuteStartMedication);
      }
      band = false;
      return DateFormat.Hm().format(fproximaToma);
  }

  int totalVecesTomaMedicacion(int valor){
    int veces = 0;
    int tomaMe = obtCantidadTomasPrimerdia(valor);
    DateTime ffinal = obtFechaFinalMedicacion(valor);
    DateTime finicio = DateTime.parse(_modelMedicamto.medicamentos.elementAt(valor).fechaCreacion);
    
    // obtengo tomas hasta el mismo dia de la fecha fin
    while(finicio.compareTo(ffinal) <= 0){
      veces = veces + tomasCadaDiaHora.length;
      finicio = finicio.add(const Duration(days: 1));
    }
    
    //Resto las veces del primer dia
    veces = veces - ((tomasCadaDiaHora.length) - tomaMe);

    //Resto las veces del ultimo dia
    veces = veces - ((tomasCadaDiaHora.length) - obtCantidadTomasUltimoDia(valor));

    return veces;
  }

  double obtPorcentajeMedicacion(int medicamto){
    int tomasHastaHoy = 0;
    int pasada = 0;
    int totTomas = totalVecesTomaMedicacion(medicamto);
    DateTime hoy = DateTime.now();
    DateTime finicio = DateTime.parse(_modelMedicamto.medicamentos.elementAt(medicamto).fechaCreacion);
    int diaMedicacion = int.parse(DateFormat.d().format(DateTime.parse(_modelMedicamto.medicamentos.elementAt(medicamto).fechaCreacion)));

  //compara por fecha 
  while(finicio.compareTo(hoy) <= 0){
    pasada ++;
    tomasHastaHoy += tomasCadaDiaHora.length;
    finicio = finicio.add(const Duration(days: 1));
  }

  if(pasada == 1 && diaMedicacion == formattedDay){ //primer dia porcentaje
  // debe contar desde la hora de inico
  var data = int.parse(DateFormat.H().format(DateTime.parse(_modelMedicamto.medicamentos.elementAt(medicamto).fechaCreacion)));
   for(data in tomasCadaDiaHora){
    if(formattedHour > data){ 
      tomasHastaHoy--;
    }
   }
  }
  else{ 
    if(pasada != _modelMedicamto.medicamentos.elementAt(medicamto).dias){
      tomasHastaHoy = tomasHastaHoy - obtCantidadTomasPrimerdia(medicamto);//tomas del primer dia 
      for(var data in tomasCadaDiaHora){ // resto del total las tomas que se han hecho hasta la hora de hoy
        if(formattedHour > data){ 
          tomasHastaHoy--;
        }
      }
    }
    else{ //ULTIMO DIA
      tomasHastaHoy = tomasHastaHoy - (tomasCadaDiaHora.length - obtCantidadTomasPrimerdia(medicamto));
      for(var data in tomasCadaDiaHora){
        if(formattedHour > data){
          tomasHastaHoy --;
        }
      }
    }
  } 
  
  // REGLA DE TRES
  print('TT $tomasHastaHoy');
  print('HORAS $tomasCadaDiaHora');
  return double.parse(((tomasHastaHoy*100)/totTomas).toStringAsFixed(1));

  }
  
  int obtCantidadTomasPrimerdia(int valor) {
    int tomas = 0; 
    int addHour = 0;
    int frecuenciaEnHoras = _modelMedicamto.medicamentos.elementAt(valor).frecuencia;
    int horaInicio = int.parse(DateFormat.H().format(DateTime.parse(_modelMedicamto.medicamentos.elementAt(valor).fechaCreacion)));
    addHour = horaInicio;

    //obtener tomas hasta las 23.59 del dia de medicacion
    while(addHour < 24){
      tomas++;
      addHour = addHour + frecuenciaEnHoras;
    }
    
    return tomas;
  }

  int obtCantidadTomasUltimoDia(int valor){

    int horadeInicioMedicacion = int.parse(DateFormat.H().format(DateTime.parse(_modelMedicamto.medicamentos.elementAt(valor).fechaCreacion)));
    int tomasUltimoDia = 0;
    for(var data in tomasCadaDiaHora){
      if(data <= horadeInicioMedicacion){
        tomasUltimoDia ++;
      }
      else{
        break;
      }
    }

    return tomasUltimoDia;
  }
  
}