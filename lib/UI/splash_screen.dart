import 'package:firebase_project/Firebase_services/splash_services.dart';
import 'package:flutter/material.dart';

class Splash_screen extends StatefulWidget {
  const Splash_screen({super.key});

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {
  splash_services splashScreen=splash_services();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen.islogin(context);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Firebase Trial",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,fontFamily: 'Poppins'),),
      ),
    );
  }
}