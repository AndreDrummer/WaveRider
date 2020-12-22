import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:waverider/custom/icons.dart';
import 'package:waverider/screens/about_screen.dart';
import 'package:waverider/screens/events_screen.dart';
import 'package:waverider/screens/news_screen.dart';
import 'package:waverider/screens/region/regions_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    final _screens = <Widget>[
      NewsScreen(),
      EventsScreen(),
      RegionScreen(),
      AboutScreen(),
    ];

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
              WaveRider.newspaper,
              size: 30,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              WaveRider.calendar_empty,
              size: 30,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              WaveRider.location,
              size: 30,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              WaveRider.info_circle,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
