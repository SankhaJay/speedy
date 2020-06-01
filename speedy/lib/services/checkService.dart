import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speedy/config/config.dart';
import 'package:speedy/screens/check_speed/check.dart';
import 'package:get_ip/get_ip.dart';
import 'package:speedy/services/testservice.dart';

class Details {
  String address;
  double latitude;
  double longitude;
  String isp;

  Details(this.address, this.latitude, this.longitude, this.isp);
}

class CheckService {
  final imgUrl = "https://unsplash.com/photos/iEJVyyevw-U/download?force=true";
  Duration time;
  final baseUrl = Config.baseUrl;

  Future<Duration> getSpeed() async {
    Dio dio = Dio();

    try {
      //print(position.latitude);
      var dir = await getApplicationDocumentsDirectory();
      var now = new DateTime.now();
      await dio.download(imgUrl, "${dir.path}/image.jpg",
          onReceiveProgress: (rec, total) {
        print("Receive: $rec, Total: $total");
        print(now);
        print(dir.path);
        Check().progressString = (((rec / total) * 100));
      });
      var later = new DateTime.now();
      print(later);
      time = later.difference(now);
      print(time.inSeconds);
    } catch (err) {
      print(err);
    }
    //return true;
    return time;
  }

  Future<List> postResult(String speed) async {
    List details_list = [];
    String isp;
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    String address = "${place.locality},${place.postalCode},${place.country}";
    print(position);
    print(speed);
    print(address);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email");
    String ip;
    print(email);
    await Dio().get('https://api.ipify.org').then((res) {
      if (res.statusCode == 200) {
        print(res);
        ip = res.data as String;
        print(ip);
      } else {
        return null;
      }
    }).catchError((err)=>false);
    print(ip);
    return await Dio().post(
      '$baseUrl/tests/check-speed',
      data: {
        "email": email,
        "speed": speed,
        "location": {
          "name": address,
          "longitude": position.longitude,
          "latitude": position.latitude
        },
        "ip": ip
      },
    ).then((res) async {
      Logger().i('$res');
      isp = res.data["data"]["isp"];
      Logger().i('${res.data["data"]}');

      if (res.statusCode == 201) {
        Logger().i('here');
        print(res);
        Details details =
            Details(address, position.latitude, position.longitude, isp);
        details_list.add(details);
        return details_list;
      }

      return false;
    }).catchError((err) => false);
  }
}
