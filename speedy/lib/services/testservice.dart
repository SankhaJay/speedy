import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speedy/config/config.dart';

class Test {
  Test(this.id, this.speed, this.isp, this.location_name, this.latitude,
      this.longitude /*this.test_time*/);

  String id;
  String speed;
  String isp;
  String location_name;
  String latitude;
  String longitude;
  //DateTime test_time;
  
}
// class Test{
//   Test(this.name);
//   String name;
// }

class TestService {
  Future<List<Test>> getTests() async {
    final baseUrl = Config.baseUrl;
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String user = prefs.getString("user");
    // Logger().i('$officer');

        SharedPreferences prefs = await SharedPreferences.getInstance();
        String email = prefs.getString("email");
    print(baseUrl);
    return await Dio()
        .get(
      '$baseUrl/tests/get-tests?email=${email}',
    )
        .then((res){
      Logger().i("$res");
      List<Test> tests = [];
      Logger().i("here: ${res.data["data"]}");
      int length = res.data["data"].length;
      if (res.statusCode == 200) {
        Logger().i("$length");
        //Logger().i("nlknklnlk${res.data["data"]["fines"]}");
        // Logger().i("vdjskbvjkdsbvkbdskvbds");

        //List<Fine> e_fines = [];
        for (int i = 0; i < length; i++) {
          
          var f = res.data["data"][i];
          var location = f["location"];
          Logger().i(f["tested_at"]);
           //Logger().i(tests);
          Test test = Test(
              f["_id"], 
              f["speed"],
              f["isp"],
              location["name"],
              location["latitude"],
              location["longitude"],
              //f["tested_at"]
          ); 
          //  Test test = Test(
          //     "id one"
          // ); 
          tests.add(test);
          //Logger().i("return tests");
          Logger().i(tests.length);
          
        }
        Logger().i("return tests");
        Logger().i("here $tests");
        return tests;
      }
      Logger().i("return false");
      return false;
    }).catchError((err) => false);
  }
}
