import 'dart:async';

import 'package:chat_me_final/services/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'chat_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future checkLogin(BuildContext context)async {

    if ( FirebaseAuth.instance.currentUser == null) {

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => LoginScreen()));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => ChatScreen()));
    }

  }



  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3), () {
      if ( FirebaseAuth.instance.currentUser == null) {

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => ChatScreen()));
      }
    }

    );

    return  Scaffold(

      body: Stack(children: [

    Positioned(top:0,left: 0,child: Image.asset(AssetsManager.background,fit: BoxFit.fitHeight,)),
       Center(

             child: Image.asset(AssetsManager.logoNewPng,height: 300,width: 300,)),


      ],),

    );
  }



  }
  

