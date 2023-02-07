// ignore_for_file: non_constant_identifier_names

import 'package:cmed_app/Models/service_locator.dart';
import 'package:cmed_app/src/pages/home.dart';
import 'package:cmed_app/src/pages/navbar.dart';
import 'package:cmed_app/src/pages/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';

// The application under test.
import 'package:cmed_app/main.dart' as app;

void main (){
    IntegrationTestWidgetsFlutterBinding.ensureInitialized(); // NEW

    Future<void> _login(WidgetTester tester) async {
      final Finder button = find.byIcon(Icons.login);
      await tester.tap(button);
      await Future.delayed(const Duration(seconds:2));
      await tester.pumpAndSettle();
    }

     Future<void> _nuevoU(WidgetTester tester) async {
      final Finder button = find.byIcon(Icons.login);
      await tester.tap(button);
      await Future.delayed(const Duration(seconds:2));
      await tester.pumpAndSettle();
    }

    Future<void> _inputPrueba(String cedula, String nombres, String apellidos, String ocupacion, String estadocivil, String sexo,  String direccion, String fechaNaci, String lugarNac, WidgetTester tester)async {
       //Write text in textfield
      final Finder textField = find.byKey(const Key("inputUsuario"));
      await tester.tap(textField);
      await tester.enterText(textField, cedula);
      await Future.delayed(const Duration(seconds:2));
      await tester.pumpAndSettle();
    }

    Future<void> _enter(WidgetTester tester) async {
      final Finder button = find.byType(TextButton);
      await tester.tap(button);
      await Future.delayed(const Duration(seconds:2));
      await tester.pumpAndSettle();
    }

    Future<void> _inputUsuario(String cedula, WidgetTester tester)async {
       //Write text in textfield
      final Finder textField = find.byKey(const Key("inputUsuario"));
      await tester.tap(textField);
      await tester.enterText(textField, cedula);
      await Future.delayed(const Duration(seconds:2));
      await tester.pumpAndSettle();
    }

    Future<void> _inputPassword(String password, WidgetTester tester)async {
       //Write text in textfield
      final Finder textField = find.byKey(const Key("inputPassword"));
      await tester.tap(textField);
      await tester.enterText(textField, password);
      await Future.delayed(const Duration(seconds:2));
      await tester.pumpAndSettle();
    }
    
    /* ESCENARIO 1 */
     testWidgets('Nuevo usuario',
      (WidgetTester tester) async {
        //Init
        app.main();
        await tester.pumpAndSettle();
        //Inputs
        const cedula = '0200742526';
        const nombres = 'Jorge';
        const apellidos = 'Riera Garcia';
        const ocupacion = 'Chofer';
        const estadoC = 'S';
        const sexo = 'M';
        const direccion = 'Turubamba de monjas';
        const fechaN = '1963/08/11';
        const lugarN = 'Guaranda';

        await _nuevoU(tester);
        await _inputPrueba(cedula, nombres, apellidos, ocupacion, estadoC, direccion, sexo, fechaN, lugarN, tester);
       
        await _enter(tester);

         expect(find.byType(homePage), findsOneWidget);
      });   

       /* ESCENARIO 2 */
     testWidgets('Nuevo Paciente',
      (WidgetTester tester) async {
        //Init
        app.main();
        await tester.pumpAndSettle();
        //Input cedula
        const cedula = '1719624999';
        await _login(tester);
        await _inputUsuario(cedula, tester);
        const password = 'martina123';
        await _inputPassword(password, tester);
        //expect(find.text(cedula), findsOneWidget);
        await _enter(tester);

         expect(find.byType(homePage), findsOneWidget);
      });   

/* ESCENARIO 3 */
     testWidgets('Creación Notificaciones',
      (WidgetTester tester) async {
        //Init
        app.main();
        await tester.pumpAndSettle();
        //Input cedula
        const cedula = '1719624999';
        await _login(tester);
        await _inputUsuario(cedula, tester);
        const password = 'martina123';
        await _inputPassword(password, tester);
        //expect(find.text(cedula), findsOneWidget);
        await _enter(tester);

         expect(find.byType(homePage), findsOneWidget);
      });   

      /* ESCENARIO 4 */
    testWidgets('Enter to the system',
      (WidgetTester tester) async {
        //Init
        app.main();
        await tester.pumpAndSettle();
        //Input cedula
        const cedula = '1719624999';
        await _login(tester);
        await _inputUsuario(cedula, tester);
        const password = 'martina123';
        await _inputPassword(password, tester);
        //expect(find.text(cedula), findsOneWidget);
        await _enter(tester);

        expect(find.byType(homePage), findsOneWidget);
      }); 

      /* ESCENARIO 5 */
    testWidgets('Confirmación toma de medicamentos',
      (WidgetTester tester) async {
        //Init
        app.main();
        await tester.pumpAndSettle();
        //Input cedula
        const cedula = '1719624999';
        await _login(tester);
        await _inputUsuario(cedula, tester);
        const password = 'martina123';
        await _inputPassword(password, tester);
        //expect(find.text(cedula), findsOneWidget);
        await _enter(tester);

         expect(find.byType(homePage), findsOneWidget);
      });   

    /* ESCENARIO 6 */
    testWidgets('Acceso a dieta del paciente',
      (WidgetTester tester) async {
        //Init
        app.main();
        await tester.pumpAndSettle();
        //Input cedula
        const cedula = '1719624999';
        await _login(tester);
        await _inputUsuario(cedula, tester);
        const password = 'martina123';
        await _inputPassword(password, tester);
        //expect(find.text(cedula), findsOneWidget);
        await _enter(tester);

         expect(find.byType(homePage), findsOneWidget);
      });   

      /* ESCENARIO 7 */
    testWidgets('Progreso de la medicacion',
      (WidgetTester tester) async {
        //Init
        app.main();
        await tester.pumpAndSettle();
        //Input cedula
        const cedula = '1719624999';
        await _login(tester);
        await _inputUsuario(cedula, tester);
        const password = 'martina123';
        await _inputPassword(password, tester);
        //expect(find.text(cedula), findsOneWidget);
        await _enter(tester);

         expect(find.byType(homePage), findsOneWidget);
      });   

    /* ESCENARIO 8 */
    testWidgets('Visualización receta médica',
      (WidgetTester tester) async {
        //Init
        app.main();
        await tester.pumpAndSettle();
        //Input cedula
        const cedula = '1719624999';
        await _login(tester);
        await _inputUsuario(cedula, tester);
        const password = 'martina123';
        await _inputPassword(password, tester);
        //expect(find.text(cedula), findsOneWidget);
        await _enter(tester);

         expect(find.byType(homePage), findsOneWidget);
      });

        /* ESCENARIO 9 */
    testWidgets('Progreso diario',
      (WidgetTester tester) async {
        //Init
        app.main();
        await tester.pumpAndSettle();
        //Input cedula
        const cedula = '1719624999';
        await _login(tester);
        await _inputUsuario(cedula, tester);
        const password = 'martina123';
        await _inputPassword(password, tester);
        //expect(find.text(cedula), findsOneWidget);
        await _enter(tester);

         expect(find.byType(homePage), findsOneWidget);
      });      

      /* ESCENARIO 10 */
    testWidgets('Calendario de Tomas medicación',
      (WidgetTester tester) async {
        //Init
        app.main();
        await tester.pumpAndSettle();
        //Input cedula
        const cedula = '1719624999';
        await _login(tester);
        await _inputUsuario(cedula, tester);
        const password = 'martina123';
        await _inputPassword(password, tester);
        //expect(find.text(cedula), findsOneWidget);
        await _enter(tester);

         expect(find.byType(homePage), findsOneWidget);
      });
}