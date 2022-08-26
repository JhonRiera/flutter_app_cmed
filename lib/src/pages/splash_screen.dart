import 'dart:ffi';

import 'package:cmed_app/Models/mobileUser.dart';
import 'package:cmed_app/src/pages/navbar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class splashScreen extends StatefulWidget {


  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> with SingleTickerProviderStateMixin{
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
      controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
      );

      controller.addStatusListener((status) {
          if(status == AnimationStatus.completed){
            Navigator.push(context, PageTransition(
                type: PageTransitionType.bottomToTop,
                child: navBarbottom(),
                isIos: false,
                duration: const Duration(milliseconds: 600)
            ));
            controller.reset();
          }
      });
  }
 
  @override
  void dispose(){
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: ListView(
        children: [
          const Divider(
                    color: Colors.transparent,
                    height: 100.0,
                ),
          Center(
            child: Lottie.asset('assets/loadingMedication.json',
              controller: controller,
              onLoaded: (composition){
                controller.forward(); 
              }
            ),
          ),
        ],
      ),
    );
  }
}