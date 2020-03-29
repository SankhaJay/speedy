import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speedy/screens/home_screen/home.dart';
import 'package:geolocator/geolocator.dart';
import 'package:speedy/services/checkService.dart';

class Check extends StatefulWidget {
  double progressString;
  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> {
  
  bool downloading = false;
  double progressString;
  double netSpeed = 0;
  String speed = '0 kbps';
  //DateTime time;
  Future<Duration> time;
  Duration timeAsDuration;
  @override
  void initState() {
    super.initState();

    checkSpeed();
  }

  Future checkSpeed() async {
    setState(() {
      downloading = true;
    });

    print("nsjdngjksnjgndngsglsdngksndgls+MLFSMB;SM;BMS;M;SM;S");
    CheckService().getSpeed().then((time){
      setState(() {
      downloading = false;
      netSpeed = 3200/time.inSeconds;
      speed = (netSpeed.toStringAsFixed(2)) + " kbps";
    });
    });

    print("nsjdngjksnjgndngsglsdngksndgls");
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: downloading
              ? Container(
                  height: 120,
                  width: 200,
                  child: Card(
                      color: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Checking speed",
                              style: TextStyle(
                                color: Colors.white,
                              ))
                        ],
                      )),
                )
              : Text("$speed\n")),
    );
  }
}
