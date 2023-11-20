import 'package:flutter/material.dart';
import 'package:app/src/confessions.dart';
import 'package:app/src/profile.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext build) {
    return Scaffold(
      body: PageView(
          controller: _pageController,
          children: [Confessions(), Profile()],
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          }),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.note_add), label: 'Confessions'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          });
        },
      ),
    );
  }
}
