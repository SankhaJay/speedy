import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:speedy/services/authService.dart';
import 'package:speedy/services/testservice.dart';

class MyTests extends StatefulWidget {
  @override
  _MyTestsState createState() => _MyTestsState();
}

class _MyTestsState extends State<MyTests> {
  @override
  //   Widget build(BuildContext context) {
  //   return  Scaffold(
  //     body:  Container(
  //       color:  Color(0xFF756AB7),
  //       child:  CustomScrollView(
  //         scrollDirection: Axis.vertical,
  //         slivers: <Widget>[
  //            SliverPadding(
  //             padding: const EdgeInsets.symmetric(vertical: 24.0),
  //             sliver:  SliverFixedExtentList(
  //               itemExtent: 152.0,
  //               delegate:  SliverChildBuilderDelegate(
  //                   (context, index) =>  Card(
  //                     child:Text("context")
  //                   ),
  //                 childCount: 10,

  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomPadding: false,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height/15,
                  ),
                  Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                      "Your previous test results",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height/20,
                    ),
                    NiceButton(
                    width: 3 * (MediaQuery.of(context).size.width) / 8,
                    elevation: 4,
                    //radius: 52,
                    onPressed: () {
                      AuthService.logout();
                      Navigator.pushNamed(context, '/');
                    },
                    text: "Logout",
                    background: Colors.red,
                  ),
                      ],
                    )
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/20,
                  ),
                  FutureBuilder(
                      future: TestService().getTests(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 10),
                                    Text(
                                      "   Test ID - ${snapshot.data[index].id}",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
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
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              "${snapshot.data[index].speed}",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              "ISP",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white),
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
                                    SizedBox(height: 10),
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
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              "${snapshot.data[index].location_name}",
                                              overflow: TextOverflow.ellipsis,
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
                                                  color: Colors.white),
                                            ),
                                            //SizedBox(height: 5),
                                            Text(
                                              "${snapshot.data[index].latitude}",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              "Longitude",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white),
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
                                      "   Tested at - 2020-03-28T04:41:08.351+00:00",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          Logger().i("$snapshot");
                          return Center(
                            child: Center(
                              child: Text("Loading"),
                            ),
                          );
                        }
                      }),
                ],
              ),
            )));
  }
}
