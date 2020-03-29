import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
<<<<<<< HEAD
=======
import 'package:speedy/screens/home_screen/home.dart';
import 'package:geolocator/geolocator.dart';
import 'package:speedy/services/checkService.dart';
>>>>>>> 758c96623c967f47c3b9a58594276f7579ec92f0

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
<<<<<<< HEAD
    Dio dio = Dio();
    try {
      var dir = await getApplicationDocumentsDirectory();
      var now = DateTime.now();
      await dio.download(imgUrl, "${dir.path}/image.jpg",
          onReceiveProgress: (rec, total) {
        print("Receive: $rec, Total: $total");
        print(now);

        setState(() {
          progressString = (((rec / total) * 100));
        });
      });
      var later = DateTime.now();
      print(later);
      time = later.difference(now);
      print(time.inSeconds);
    } catch (err) {
      print(err);
    }
    setState(() {
      downloading = false;
      netSpeed = 4000 / time.inSeconds;
=======

    print("nsjdngjksnjgndngsglsdngksndgls+MLFSMB;SM;BMS;M;SM;S");
    CheckService().getSpeed().then((time){
      setState(() {
      downloading = false;
      netSpeed = 3200/time.inSeconds;
>>>>>>> 758c96623c967f47c3b9a58594276f7579ec92f0
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
