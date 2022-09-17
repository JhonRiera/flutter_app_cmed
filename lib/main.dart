import 'package:cmed_app/Models/service_locator.dart';
import 'package:cmed_app/src/pages/default_page.dart';
import 'package:cmed_app/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'dart:isolate';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

/// The [SharedPreferences] key to access the alarm fire count.
const String countKey = 'count';

/// The name associated with the UI isolate's [SendPort].
const String isolateName = 'isolate';

/// A port used to communicate from a background isolate to the UI isolate.
final ReceivePort port = ReceivePort();

/// Global [SharedPreferences] object.
SharedPreferences? prefs;


Future<void> main() async => {  
  WidgetsFlutterBinding.ensureInitialized(), 

  // Register the UI isolate's SendPort to allow for communication from the
  // background isolate.
   IsolateNameServer.registerPortWithName(
    port.sendPort,
    isolateName,
  ),
   prefs = await SharedPreferences.getInstance(),
  if (!prefs!.containsKey(countKey)) {
    await prefs!.setInt(countKey, 0),
  },

    runApp(Cmed()),
    await setUp(), 
    //runApp(Cmed()), 
    await AndroidAlarmManager.initialize(),
};

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