import 'package:flutter/material.dart';
import 'package:speedy/routes/application.dart';

class CheckSpeed extends StatefulWidget {
  @override
  _CheckSpeedState createState() => _CheckSpeedState();
}

class _CheckSpeedState extends State<CheckSpeed> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Check speed"));
  }
}

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Map"));
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

//MAIN HOMEPAGE CLASS
class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List<Widget> _widgetOptions = <Widget>[
    //list of bottom navigation bar items
    CheckSpeed(),
    Map()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; //on strtup navigate yo view fines
    });
  }

//botttom navigation bar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            title: Text('New fine'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit), title: Text('View Fines')),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
