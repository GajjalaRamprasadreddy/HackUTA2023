import 'package:flutter/material.dart';

import 'BottomNavigationScreen.dart';


class DashboardBaseScreen extends StatefulWidget {
  const DashboardBaseScreen({Key? key}) : super(key: key);

  @override
  State<DashboardBaseScreen> createState() => _DashboardBaseScreenState();
}

class _DashboardBaseScreenState extends State<DashboardBaseScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: BottomNavigationScreen(), // Set HomeScreen as the home page.
    );
  }
}
