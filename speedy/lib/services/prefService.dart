import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  Future<bool> setToken(String token) {
    return SharedPreferences.getInstance()
        .then((instance) => instance
            .setString("token", token)
            .then((success) => true)
            .catchError((onError) => false))
        .catchError((error) {
      Logger().e(error);
      return false;
    });
  }

  Future<String> getToken() {
    return SharedPreferences.getInstance()
        .then((instance) => instance.getString("token"))
        .catchError((error) => Logger().e(error));
  }

  // Future<bool> createSession() {
  //   return SharedPreferences.getInstance()
  //       .then((instance) => instance
  //           .setString("token", token)
  //           .then((success) => true)
  //           .catchError((onError) => false))
  //       .catchError((error) {
  //     Logger().e(error);
  //     return false;
  //   });
  // }

  Future<bool> getSession() {
    return SharedPreferences.getInstance()
        .then((instance) => instance.getBool("isSession"))
        .catchError((error) => Logger().e(error));
  }

  
}
