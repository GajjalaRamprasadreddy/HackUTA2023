import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = "";
  @override
  void initState() {
    super.initState();
    setState(() {
      name = FirebaseAuth.instance.currentUser?.email ?? "";

    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(child: Text(name)),
    );
  }
}
