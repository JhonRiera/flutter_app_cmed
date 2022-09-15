import 'package:cmed_app/Models/service_locator.dart';
import 'package:cmed_app/src/pages/default_page.dart';
import 'package:cmed_app/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

void main() async => {  WidgetsFlutterBinding.ensureInitialized(), await setUp(), runApp(Cmed()), await AndroidAlarmManager.initialize()};

class Cmed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: getRoutes(),
      onGenerateRoute: (RouteSettings seeting) {
        return MaterialPageRoute(
          builder: ((context) => defaultPage()));
      }, 
    );
  }
}