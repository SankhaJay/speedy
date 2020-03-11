import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speedy/screens/home_screen/home.dart';

class Check extends StatefulWidget {
  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> {
  final imgUrl = "https://unsplash.com/photos/iEJVyyevw-U/download?force=true";
  bool downloading = false;
  double progressString;
  double netSpeed = 0;
  String speed = '0 kbps';
  //DateTime time;
  Duration time;
  @override
  void initState() {
    super.initState();

    checkSpeed();
  }

  Future<void> checkSpeed() async {
    setState(() {
      downloading = true;

    });
    Dio dio = Dio();
    try {
      var dir = await getApplicationDocumentsDirectory();
      var now = new DateTime.now();
      await dio.download(imgUrl,"${dir.path}/image.jpg",onReceiveProgress: (rec, total){
        print("Receive: $rec, Total: $total");
        print(now);

        setState(() {
          progressString = (((rec/total)*100));
        });
      }); 
      var later = new DateTime.now();
      print(later);
      time = later.difference(now);
      print(time.inSeconds);
    }
    catch(err){
      print(err);
    }
    setState(() {
      downloading = false;
      netSpeed = 4000/time.inSeconds;
      speed = (netSpeed.toStringAsFixed(2)) + " kbps";
    });
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
              : Text("$speed")),
    );
  }
}
