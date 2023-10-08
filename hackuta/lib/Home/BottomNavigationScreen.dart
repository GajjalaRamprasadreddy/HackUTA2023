import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:philia/Home/profile_screen.dart';
import 'package:philia/wishes/create_post_screen.dart';

import 'dashboard_screen.dart';
import 'friends_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedIndex = 0;

  // Define a list of pages for the bottom navigation bar.
  final List<Widget> _pages = [
    // Add your home page content here.
    // Example:
    // HomePage(),
    DashboardScreen(),
    FriendsScreen(),
    CreatePostScreen(),
    ProfileScreen()

    // Add more pages as needed.
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.dashboard,
                  color: Colors.grey,
                ),
                label: 'Dashboard',
                activeIcon: Icon(Icons.dashboard, color: Color(0xFF04B7B1))),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.group,
                  color: Colors.grey,
                ),
                label: 'Friends',
                activeIcon: Icon(Icons.group, color: Color(0xFF04B7B1))),

            BottomNavigationBarItem(
                icon: Icon(
                  Icons.smart_toy,
                  color: Colors.grey,
                ),
                label: 'Ai',
                activeIcon:
                Icon(Icons.smart_toy, color: Color(0xFF04B7B1))),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                label: 'Profile',
                activeIcon:
                Icon(Icons.person, color: Color(0xFF04B7B1))),
          ],
          selectedLabelStyle: TextStyle(color: Color(0xFF04B7B1)),
          selectedItemColor: Color(0xFF04B7B1)),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
