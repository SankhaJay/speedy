import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:speedy/services/authService.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String _email, _password;
  var firstColor = Color(0xff5b86e5);
  var green = Color(0xff00e600);
  var blue = Color(0xff005c99);
  var gold = Color(0xffffff00);
  static final _formKey = new GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isenabled;
  @override
  void initState() {
    super.initState();
    isenabled = true;
  }

  Future _handleLogin(
    String _email,
    String _password,
    BuildContext context,
  ) async {
    AuthService().login(_email, _password).then((res) {
      if (res) {
        Navigator.pushNamed(context, '/home');
      } else {
        isenabled = true;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Invalid credentials"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Okay"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      }
    });
    //isenabled = true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomPadding: false,
            body: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 200),
                  Center(
                      child: Text(
                    "Welcome",
                    style: TextStyle(
                      fontFamily: 'Corben',
                      color: Colors.yellow,
                      // fontWeight: FontWeight.w700,
                      fontSize: 24,
                      // color: Colors.black,
                    ),
                  )),
                  Container(
                    width: 5 * (MediaQuery.of(context).size.width) / 8,
                    child: TextFormField(
                      obscureText: false,
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow),
                        ),
                        labelText: "Email",
                        labelStyle: TextStyle(
                          color: Colors.black
                        ),

                        
                        fillColor: Colors.white,
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  Container(
                    width: 5 * (MediaQuery.of(context).size.width) / 8,
                    child: TextFormField(
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow),
                        ),
                        labelText: "Password",
                         labelStyle: TextStyle(
                          color: Colors.black
                        ),
                        fillColor: Colors.white,
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  SizedBox(height: 20),
                  NiceButton(
                    width: 1 * (MediaQuery.of(context).size.width) / 4,
                    elevation: 4,
                    //radius: 52,
                    onPressed: () {
                      _handleLogin(_email, _password, context);
                    },
                    text: "Login",
                    background: gold,
                  ),
                ],
              ),
            )));
    // return Scaffold(
    //     key: scaffoldKey,
    //     body: Form(
    //       key: _formKey,
    //       child: Column(
    //         children: <Widget>[
    //           SizedBox(
    //             height: 50,
    //           ),
    //           Expanded(
    //             child: Container(
    //               width: 200,
    //               height: 200,
    //               child: Image.asset("lib/images/officer_login.png"),
    //             ),
    //           ),
    //           SizedBox(
    //             height: 20,
    //           ),
    //           Container(
    //             width: 7 * (MediaQuery.of(context).size.width) / 8,
    //             child: TextFormField(
    //               obscureText: false,
    //               onChanged: (value) {
    //                 setState(() {
    //                   _email = value;
    //                 });
    //               },
    //               decoration: new InputDecoration(
    //                 labelText: "User Email",
    //                 fillColor: Colors.white,
    //                 border: new OutlineInputBorder(
    //                   borderRadius: new BorderRadius.circular(25.0),
    //                   borderSide: new BorderSide(),
    //                 ),
    //               ),
    //               keyboardType: TextInputType.text,
    //               style: new TextStyle(
    //                 fontFamily: "Poppins",
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             height: 20,
    //           ),
    //           Container(
    //             width: 7 * (MediaQuery.of(context).size.width) / 8,
    //             child: TextFormField(
    //               obscureText: true,
    //               onChanged: (value) {
    //                 setState(() {
    //                   _password = value;
    //                 });
    //               },
    //               decoration: new InputDecoration(
    //                 labelText: "Password",
    //                 fillColor: Colors.white,
    //                 border: new OutlineInputBorder(
    //                   borderRadius: new BorderRadius.circular(25.0),
    //                   borderSide: new BorderSide(),
    //                 ),
    //               ),
    //               keyboardType: TextInputType.text,
    //               style: new TextStyle(
    //                 fontFamily: "Poppins",
    //               ),
    //             ),
    //           ),

    //           SizedBox(
    //             height: 15,
    //           ),
    //           // RaisedButton(
    //           //   onPressed: () {
    //           //     if (_formKey.currentState.validate()) {
    //           //       if (isenabled) {
    //           //         isenabled = false;
    //           //         _handleLogin(_id, _password, context);
    //           //       } else {
    //           //         return null;
    //           //       }
    //           //     }
    //           //   },
    //           //   textColor: Colors.white,
    //           //   child: const Text('Login', style: TextStyle(fontSize: 20)),
    //           //   color: Colors.lightBlue,
    //           // ),
    //           NiceButton(
    //             width: 3 * (MediaQuery.of(context).size.width) / 4,
    //             elevation: 8,
    //             radius: 52,
    //             onPressed: (){
    //               _handleLogin(_email, _password, context);
    //             },
    //             text: "Login",
    //             background: green,
    //           ),
    //           SizedBox(
    //             height: 10
    //           ),
    //           Text("OR"),
    //           SizedBox(
    //             height: 10
    //           ),
    //           NiceButton(
    //             width: 3 * (MediaQuery.of(context).size.width) / 8,
    //             elevation: 8,
    //             radius: 52,
    //             onPressed: (){
    //               Navigator.pushNamed(context, '/reg');
    //             },
    //             text: "Register",
    //             background: blue,
    //           ),
    //           Expanded(
    //             child: Container(),
    //           )
    //         ],
    //       ),
    //     ));
  }
}

void _showErrorDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Material Dialog'),
          content: Text('This is the content of the material dialog'),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  _dismissDialog(context);
                },
                child: Text('Close')),
            FlatButton(
              onPressed: () {
                print('HelloWorld!');
                _dismissDialog(context);
              },
              child: Text('Print HelloWorld!'),
            )
          ],
        );
      });
}

_dismissDialog(BuildContext context) {
  Navigator.pop(context);
}
