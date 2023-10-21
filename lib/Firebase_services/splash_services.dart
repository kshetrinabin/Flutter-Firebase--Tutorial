import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/UI/login_page.dart';
import 'package:firebase_project/UI/upload_image.dart';

import 'package:flutter/material.dart';
import 'dart:async';

class splash_services{

  void islogin(BuildContext context){

    final auth=FirebaseAuth.instance;
    final user=auth.currentUser;

    if(user!=null){

      Timer(const Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadImg()));

     });

    }
    else{
      Timer(const Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyLogin()));

     });
    }
    
  }
}