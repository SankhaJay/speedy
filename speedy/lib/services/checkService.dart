import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speedy/screens/check_speed/check.dart';

class CheckService {
  final imgUrl = "https://unsplash.com/photos/iEJVyyevw-U/download?force=true";
  Duration time;

  Future<Duration> getSpeed() async {
    Dio dio = Dio();
    try {
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      //print(position.latitude);
      var dir = await getApplicationDocumentsDirectory();
      var now = new DateTime.now();
      await dio.download(imgUrl,"${dir.path}/image.jpg",onReceiveProgress: (rec, total){
        print("Receive: $rec, Total: $total");
        print(now);
        print(dir.path);
          Check().progressString = (((rec/total)*100));
      }); 
      var later = new DateTime.now();
      print(later);
      time = later.difference(now);
      print(time.inSeconds);
      return time;
    }
    catch(err){
      print(err);
    }
  }

}