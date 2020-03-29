
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:speedy/routes/application.dart';
import 'package:speedy/routes/routes.dart';
import 'package:speedy/screens/auth_screen/auth.dart';
import 'package:speedy/screens/check_speed/check.dart';
import 'package:speedy/screens/home_screen/home.dart';
import 'package:speedy/screens/reg_screen/reg.dart';
import 'package:speedy/screens/spash_screen/splash.dart';

class Speedy extends StatelessWidget {
  Speedy() {
    //configure routing using fluro plugin
    final router = Router();
    Routes.configureRouter(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    //main MaterialApp widget of the app
    return MaterialApp(
      title: "Speedy",
      debugShowCheckedModeBanner: false,
      //onGenerateRoute: Application.router.generator,
      initialRoute: '/',
      routes:{
        '/': (context) => SplashScreen(),
        '/auth': (context) => AuthScreen(),
        '/home': (context) => HomeScreen(),
        '/check': (context) => Check(),
        '/reg': (context) => Register(),
      }
    );
  }
}

