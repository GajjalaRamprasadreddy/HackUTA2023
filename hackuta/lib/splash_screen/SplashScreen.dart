import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:philia/util/CollectionConstants.dart';
import 'package:philia/util/MyLoadingWidget.dart';

import '../model/UserInfo.dart';
import '../router/route_names.dart';
import '../util/AppPreference.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();

    handleUserDetails();
  }

  void handleUserDetails() async {
    if (FirebaseAuth.instance.currentUser != null) {
      await db
          .collection(CollectionConstants.USERS)
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get()
          .then((event) {
        Users user = Users.fromMap(event.data() as Map<String, dynamic>);
        print("ram user : " + user.toMap().toString());
        AppPreference().user = user;
      });
      if (AppPreference().user != null) {
        _moveToHomeScreen();
      } else {
        _addDetails();
      }
    } else {
      movetoSignInScreen();
    }
  }

  void movetoSignInScreen() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(context, signinRoute);
    });
  }

  void _moveToHomeScreen() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(context, dashboardRoute);
    });
  }

  void _addDetails() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacementNamed(addPersonalDetails);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Image.asset(
              'assets/images/splash.gif'
            ),
          ),
        ),
      ),
    );
  }
}
