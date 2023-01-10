// ignore_for_file: camel_case_types

import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class dietCard extends StatelessWidget{

  late Color color;
  //late Icon icon;
  late String title;
  late String subtitleOne;
  late String subtitleTwo;
  late DateTime fechaIncio;

  dietCard(
    {Key? key, 
    required this.color,
    required this.title,
    required this.subtitleOne,
    required this.subtitleTwo,
    required this.fechaIncio
    }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container();
  }
  
}