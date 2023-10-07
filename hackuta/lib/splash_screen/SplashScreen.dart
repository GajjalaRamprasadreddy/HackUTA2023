import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:philia/util/MyLoadingWidget.dart';

import '../router/route_names.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  @override
  void initState() {
    super.initState();
      if(FirebaseAuth.instance.currentUser!=null){
        _moveToHomeScreen();
      }
  }

  void movetoSignInScreen(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushNamed(context, signinRoute);
    });
  }

  void _moveToHomeScreen() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushNamed(homeRoute);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: MyLoadingWidget()),
    );
  }
}
