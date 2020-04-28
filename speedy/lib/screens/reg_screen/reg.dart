import 'package:flutter/material.dart';
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

  Future registerUser(Map user) async {
    AuthService().register(user).then((res) {
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
        body: SingleChildScrollView(
            child: Form(
          key: _regFormKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 75,
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
                      width: 320,
                      child: TextFormField(
                        obscureText: false,
                        onChanged: (value) {
                          setState(() {
                            user['email'] = value;
                          });
                        },
                        validator: (val) {},
                        decoration: InputDecoration(
                          labelText: "Your Email",
                        ),
                        keyboardType: TextInputType.text,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ))),
              SizedBox(
                height: 8,
              ),
              Center(
                  child: Container(
                      width: 320,
                      child: TextFormField(
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            user['password'] = value;
                          });
                        },
                        validator: (val) {},
                        decoration: InputDecoration(
                          labelText: "Password",
                        ),
                        keyboardType: TextInputType.text,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ))),
              SizedBox(
                height: 8,
              ),
              Center(
                  child: Container(
                      width: 320,
                      child: TextFormField(
                        obscureText: false,
                        onChanged: (value) {
                          setState(() {
                            user['first_name'] = value;
                          });
                        },
                        validator: (val) {},
                        decoration: InputDecoration(
                          labelText: "First Name",
                        ),
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ))),
              SizedBox(
                height: 8,
              ),
              Center(
                  child: Container(
                      width: 320,
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
              SizedBox(
                height: 8,
              ),
              Center(
                  child: Container(
                      width: 320,
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
                height: 20,
              ),
            
              NiceButton(
                width: 3 * (MediaQuery.of(context).size.width) / 8,
                elevation: 8,
                // radius: 52,
                onPressed: () {
                  registerUser(user);
                },
                text: "Register",
                background: Colors.black,
              ),
            ],
          ),
        )));
  }
}
