import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speedy/screens/home_screen/CheckSpeed.dart';
import 'package:speedy/screens/home_screen/MapX.dart';

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
    MapX()
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
            title: Text('Test Speed'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit), 
              title: Text('Map')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), 
              title: Text('My Tests')
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
