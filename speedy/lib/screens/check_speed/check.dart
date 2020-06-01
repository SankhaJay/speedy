import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:nice_button/NiceButton.dart';
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
  Future<List> details;
  bool downloading = false;
  double progressString;
  double netSpeed = 0;
  String speed = '0 kbps';
  String location;
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
    await CheckService().getSpeed().then((time) async {
      setState(() {
        downloading = false;
        netSpeed = 3305 / time.inSeconds;
        speed = (netSpeed.toStringAsFixed(2)) + " kbps";
      });
      // details = await ;
      Logger().i(details);
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
                : FutureBuilder(
                    future: CheckService().postResult(speed),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        Logger().i(snapshot);
                        return Column(
                          children: <Widget>[
                            SizedBox(
                              height: 75,
                            ),
                            Text(
                              "Your test details",
                              style: TextStyle(fontSize: 20),
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(top: 20, bottom: 30),
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  height: 200,
                                  width: 11 *
                                      (MediaQuery.of(context).size.width) /
                                      12,
                                  margin: EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                      color: Color(0xFF333366),
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(8.0),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 10.0,
                                            offset: Offset(0.0, 10.0))
                                      ]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: 10),
                                      Text(
                                        "   Test ID ",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Column(
                                            children: <Widget>[
                                              Text(
                                                "Speed",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,fontWeight: FontWeight.w700,),
                                              ),
                                              Text(
                                                speed,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Column(
                                            children: <Widget>[
                                              Text(
                                                "ISP",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,fontWeight: FontWeight.w700,),
                                              ),
                                              Text(
                                                "${snapshot.data[index].isp}",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Column(
                                            children: <Widget>[
                                              Text(
                                                "Location",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,fontWeight: FontWeight.w700,),
                                              ),
                                              Text(
                                                "${snapshot.data[index].address}",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Column(
                                            children: <Widget>[
                                              Text(
                                                "Latitude",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,fontWeight: FontWeight.w700,),
                                              ),
                                              //SizedBox(height: 5),
                                              Text(
                                                "${snapshot.data[index].latitude}",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Text(
                                                "Longitude",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,fontWeight: FontWeight.w700,),
                                              ),
                                              //SizedBox(height: 5),
                                              Text(
                                                "${snapshot.data[index].longitude}",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "   Tested at - ${DateTime.now()}",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            NiceButton(
                              width:
                                  3 * (MediaQuery.of(context).size.width) / 8,
                              elevation: 8,
                              //radius: 52,
                              onPressed: () {
                                Navigator.pushNamed(context, '/home');
                              },
                              text: "Go Back",
                              background: Colors.black,
                            ),
                          ],
                        );
                      } else {
                        return Center(child: Text("waiting for the results"));
                      }
                    })));
  }
}
