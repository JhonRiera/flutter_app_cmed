// ignore_for_file: file_names, prefer_interpolation_to_compose_strings

class BaseApi{

  static String base = "http://192.168.100.20:4000";
  
  var mobileUsers = base + "/personas/usuarios/mobile";
  var medicamentos = base + "/persona/paciente/medicamentos";
  var dietas = base + "/persona/paciente/dietas";
  var recetaM = base + "/persona/paciente/recetaM";
  var actualizaUltAcesso =  base + "/usuario/actualizarultacceso";
  var progresoDiario = base + "/alarmas-date";
  var actualizarAlarma = base + "/alarmas-actualizar";
  var obtenerPersonaCedula = base + "/persona/cedula"; 

  Map<String,String> headers = {                           
       "Content-Type": "application/json; charset=UTF-8" 
  }; 

}