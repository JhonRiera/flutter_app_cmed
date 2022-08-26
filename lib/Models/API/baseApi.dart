// ignore_for_file: file_names, prefer_interpolation_to_compose_strings

class BaseApi{

  static String base = "http://192.168.100.20:4000";
  
  var mobileUsers = base + "/personas/usuarios/mobile";

  Map<String,String> headers = {                           
       "Content-Type": "application/json; charset=UTF-8" 
  }; 

  

}