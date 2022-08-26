import 'package:cmed_app/src/pages/home.dart';
import 'package:cmed_app/src/pages/PrincipalP.dart';
import 'package:cmed_app/src/pages/login.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getRoutes(){
  return <String, WidgetBuilder> {
    '/': (BuildContext context) => principalPage(),
    'login': (BuildContext context) => loginPage()

  };
}