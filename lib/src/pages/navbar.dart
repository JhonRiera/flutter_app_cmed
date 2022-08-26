import 'package:cmed_app/Models/mobileUser.dart';
import 'package:cmed_app/src/pages/default_page.dart';
import 'package:cmed_app/src/pages/dietas.dart';
import 'package:cmed_app/src/pages/home.dart';
import 'package:cmed_app/src/pages/medicamentos.dart';
import 'package:cmed_app/src/pages/recetas_medicas.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

// ignore: camel_case_types
class navBarbottom extends StatefulWidget {

  @override
  State<navBarbottom> createState() => _navBarbottomState();
}

// ignore: camel_case_types
class _navBarbottomState extends State<navBarbottom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
              bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: _page,
          height: 60.0,
          items: const <Widget>[
            Icon(Icons.home,color:Colors.white, size: 25),
            Icon(Icons.restaurant_menu,color:Colors.white, size: 25),
            Icon(Icons.medication,color:Colors.white, size: 25),
            Icon(Icons.article,color:Colors.white, size: 25),
          ],
          color: const Color.fromRGBO(0, 65, 196, 1),
          buttonBackgroundColor: const Color.fromRGBO(0, 65, 196, 1),
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (int tappedIndex) {
            setState(() {
              _showPage= _pageChooser(tappedIndex);
            });
          },
          letIndexChange: (index) => true,
        ),
        body: Container(
          color: Colors.white,
          child: Center(
            child: _showPage,
          ),
        )
    );
  }

  final int _page = 0;

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  //Creacion de pages para Bottom Nav Bar
  final homePage _listHomePage =  homePage();
  final dietasPage _listDietas = const dietasPage();
  final medicamentosPage _listMedicamentos = const medicamentosPage();
  final recetaMPage _listRecetasMedicas = const recetaMPage();
  // ignore: non_constant_identifier_names
  final defaultPage _ListDefaultP = const defaultPage();


  Widget _showPage =  homePage();

  Widget _pageChooser(int page){
      switch (page) {
        case 0:
        return _listHomePage;
        case 1:
        return _listDietas; 
        case 2:
        return _listMedicamentos;
        case 3:
        return _listRecetasMedicas;
        default:
        return _ListDefaultP;
  }
}
}