
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speedy/config/config.dart';
import 'package:speedy/services/prefService.dart';

String userMail;

class AuthService {
  final baseUrl = Config.baseUrl;
  Future<bool> login(String email, String password){
    userMail = email;
    Logger().i('$email');
    Logger().i('$password');
    Logger().i( 'Uri $baseUrl/auth/login?officer_id=$email&password=$password');
    return Dio().get(
      '$baseUrl/auth/login?user_email=$email&password=$password',
      // data: {
      //   "officerID": id, 
      //   "password": password,
      // },  
    ).then((res) async {
      Logger().i('$res');
      if (res.statusCode == 200) {
        print(res);
        String token = res.data["data"]["token"];
        return await _saveToken(token);
      }
      return false;
    }).catchError((err) => false);
  }

  Future<bool> logout()  async {
    //BuildContext context;
    await SharedPreferences.getInstance().then((prefs){
          prefs.remove("token");
          
          //Application.router.navigateTo(context,'/',clearStack: true);
          
    });
    
  Logger().i("logout");
    return true;
  }

  Future<bool> _saveToken(String token) async {
    return await SharedPreferences.getInstance().then((instance) {
      //Logger().i('$token');
      print(token);
      instance.setString("email", userMail);
      instance.setString("token", token);
      return true;
    }).catchError((err) => false);
  }
  
  Future<bool> isLoggedIn(){
    return PrefService()
        .getToken()
        .then((token) => (token != null) ? true : false)
        .catchError((error) => Logger().e(error));
  }
  
}

