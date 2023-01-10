// ignore_for_file: camel_case_types, must_be_immutable

import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class pillCard extends StatelessWidget{

  late Color color;
  //late Icon icon;
  late String title;
  late String subtitleOne;
  late String subtitleTwo;
  late Time hora;
  late bool estadoBoton;

   pillCard(
    {
      required this.color,
      required this.title,
      required this.subtitleOne,
      required this.subtitleTwo,
      required this.hora,
      required this.estadoBoton,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}