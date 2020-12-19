import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:waverider/screens/about_screen.dart';
import 'package:waverider/screens/events/events_screen.dart';
import 'package:waverider/screens/news/news_screen.dart';
import 'package:waverider/screens/wave_spots_screen.dart';

class Home extends StatefulWidget {
  Home({
    Key key,
    this.title,
  }) : super(key: key);
  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onSelectIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _screens = <Widget>[
    NewsScreen(),
    EventsScreen(),
    WaveSpotsScreen(),
    AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onSelectIndex,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.white38,
        fixedColor: Colors.white,
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.fiber_new_sharp,
              size: 30,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.event,
              size: 30,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.pin_drop_sharp,
              size: 30,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.info,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
