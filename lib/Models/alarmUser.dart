// ignore_for_file: non_constant_identifier_names, unnecessary_this, avoid_print

class Alarma {
  String cod_alarma;
  bool estado;
  String tiempo_recordatorio;
  
  Alarma({
    required this.cod_alarma,
    required this.estado,
    required this.tiempo_recordatorio,
  });

  factory Alarma.fromJson(dynamic json){
    return Alarma(
      cod_alarma: json["cod_alarma"] as String,
      estado: json["estado"] as bool,
      tiempo_recordatorio: json["tiempo_recordatorio"] as String
    );
  }

  void printAttributes(){
    print("cod_alarma: ${this.cod_alarma}\n");
    print("estado: ${this.estado}\n");
    print("tiempo_recor: ${this.tiempo_recordatorio}\n");
  }
}