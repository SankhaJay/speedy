import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:speedy/routes/application.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CheckSpeed extends StatefulWidget {
  @override
  _CheckSpeedState createState() => _CheckSpeedState();
}

class _CheckSpeedState extends State<CheckSpeed>
    with SingleTickerProviderStateMixin {
  AnimationController animController;
  Animation<double> value;
  
  @override
  void initState() {
    super.initState();
    animController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    value = Tween<double>(begin: 0, end: 100).animate(animController)
      ..addListener((){
        setState(() {});
      })..addStatusListener((status){
        if(status == AnimationStatus.completed){
          animController.reverse();
        }
        else if(status == AnimationStatus.dismissed){
          animController.forward();
        }
      });

    animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Check speed",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          SizedBox(
            height: 200,
            child: SfRadialGauge(
            
            axes: <RadialAxis>[
            RadialAxis(
              minimum: 0,
              maximum: 150,
              ranges: <GaugeRange>[
                GaugeRange(startValue: 0, endValue: 50, color: Colors.green),
                GaugeRange(startValue: 50, endValue: 100, color: Colors.orange),
                GaugeRange(startValue: 100, endValue: 150, color: Colors.red)
              ],
              pointers: <GaugePointer>[
                NeedlePointer(value: value.value, enableAnimation: true)
              ],
              annotations: <GaugeAnnotation>[
                // GaugeAnnotation(
                //     widget: Container(
                //         child: Text('90.0',
                //             style: TextStyle(
                //                 fontSize: 25, fontWeight: FontWeight.bold))),
                //     angle: 90,
                //     positionFactor: 0.5)
              ],
            )
          ]),
          ),
          
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/check');
            },
            color: Colors.green,
            child: Text(
              "Check my speed",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          )
        ],
      ),
    ));
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }
}

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  final LatLng _center = const LatLng(45.521563, -122.677433);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            )));
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
            title: Text('Test Speed'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit), 
              title: Text('Map')
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
