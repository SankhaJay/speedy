import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:speedy/services/authService.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 5), () async {
      //  Navigator.pushNamed(context, '/auth');
      await AuthService.isLoggedIn().then((_){
         if(_){
           Navigator.pushNamed(context, '/home');
         }
         else{
           Navigator.pushNamed(context, '/auth');
         }
       });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: <Widget>[
            // Logo(), //sing stateless widget classses to show images
            SizedBox(
              height: MediaQuery.of(context).size.height/3
            ),
            Text(
              "Welcome to Speedy",
              textDirection: TextDirection.ltr,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              child: SpinKitDoubleBounce(
                color: Colors.yellow,
              ),
            )
          ],
        ),
      ),
    );
  }
}

//insert images as statlessss widget
class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('lib/images/logo.png');
    Image image = Image(
      image: assetImage,
      width: 100,
      height: 100,
    );
    return Container(
      child: image,
      margin: EdgeInsets.only(top: 200),
    );
  }
}
