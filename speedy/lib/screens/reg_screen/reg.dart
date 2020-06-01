import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:speedy/services/authService.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  static final _regFormKey = new GlobalKey<FormState>();
  FocusNode _focusNode = new FocusNode();
  String email;
  String password;
  String first_name;
  String last_name;
  String contact_number;
  var user = Map();
  var yellow = Color(0xffcccc00);
  bool status;

  @override
  void initState() {
    super.initState();
    status = false;
  }

  Future registerUser(Map user) async {
    setState(() {
      status = true;
    });
    await AuthService().register(user).then((res) {
      setState(() {
        status = false;
      });
      if (res) {
        Navigator.pushNamed(context, '/home');
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: status
            ? Container(
                child: SpinKitDualRing(
                  color: Colors.yellow,
                ),
              )
            : Form(
                key: _regFormKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 10,
                      ),
                      Text(
                        "Register to our system here",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Center(
                          child: Container(
                              width:
                                  11 * MediaQuery.of(context).size.width / 12,
                              child: TextFormField(
                                obscureText: false,
                                onChanged: (value) {
                                  setState(() {
                                    user['email'] = value;
                                  });
                                },
                                validator: (val) {
                                  Pattern pattern =
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                  RegExp regex = new RegExp(pattern);
                                  if (!regex.hasMatch(val)) {
                                    return 'Enter Valid Email';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: "Your Email",
                                ),
                                keyboardType: TextInputType.text,
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                ),
                              ))),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height/100,
                      // ),
                      Center(
                          child: Container(
                              width:
                                  11 * MediaQuery.of(context).size.width / 12,
                              child: TextFormField(
                                obscureText: true,
                                onChanged: (value) {
                                  setState(() {
                                    user['password'] = value;
                                  });
                                },
                                validator: (val) {
                                  if (val.length == 0) {
                                    return "password cannot be empty";
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: "Password",
                                ),
                                keyboardType: TextInputType.text,
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                ),
                              ))),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height/20,
                      // ),
                      Center(
                          child: Container(
                              width:
                                  11 * MediaQuery.of(context).size.width / 12,
                              child: TextFormField(
                                obscureText: false,
                                onChanged: (value) {
                                  setState(() {
                                    user['first_name'] = value;
                                  });
                                },
                                validator: (val) {
                                  if (val.length == 0) {
                                    return "First name cannot be empty";
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: "First Name",
                                ),
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                ),
                              ))),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height/20,
                      // ),
                      Center(
                          child: Container(
                              width:
                                  11 * MediaQuery.of(context).size.width / 12,
                              child: TextFormField(
                                obscureText: false,
                                onChanged: (value) {
                                  setState(() {
                                    user['last_name'] = value;
                                  });
                                },
                                validator: (val) {},
                                decoration: InputDecoration(
                                  labelText: "Last Name",
                                ),
                                keyboardType: TextInputType.text,
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                ),
                              ))),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height/20,
                      // ),
                      Center(
                          child: Container(
                              width:
                                  11 * MediaQuery.of(context).size.width / 12,
                              child: TextFormField(
                                obscureText: false,
                                onChanged: (value) {
                                  setState(() {
                                    user['contact_number'] = value;
                                  });
                                },
                                validator: (val) {},
                                decoration: InputDecoration(
                                  labelText: "Contact Number",
                                ),
                                keyboardType: TextInputType.text,
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                ),
                              ))),

                      SizedBox(
                        height: MediaQuery.of(context).size.height / 10,
                      ),

                      NiceButton(
                        width: 3 * (MediaQuery.of(context).size.width) / 8,
                        elevation: 8,
                        // radius: 52,
                        onPressed: () {
                          // registerUser(user);
                          if (_regFormKey.currentState.validate()) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildAboutDialog(context, user),
                            );
                          }
                        },
                        text: "Register",
                        background: Colors.black,
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height / 3.5,
                      ),
                    ],
                  ),
                )));
  }

  Widget _buildAboutDialog(BuildContext context, Map user) {
    return AlertDialog(
      title: const Text(
          'Speedy is an data collecting App for only educational purposes.'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // SafeArea(child: Markdown(
          //   data: _markdown,
          //   controller: controller,
          //   selectable: true,
          // ))
          Text("""•We will get your email address.\n•Your current location will be exposed when checking the network speed.\n•Some amount of data will be charged from you when you do a speed test(below 10mb).\n\nWe won't share your information with anyone""")
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            SystemNavigator.pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Cancel & quit from the App'),
        ),
        FlatButton(
          onPressed: () {
            registerUser(user);
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Okay, got it!'),
        ),
      ],
    );
  }
}
