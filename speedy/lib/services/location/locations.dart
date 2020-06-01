import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'locations.g.dart';

@JsonSerializable()
class LocationData {
  LocationData({
    this.speed,
    this.lng,
    this.lat,
    this.name,
    this.isp
  });

  factory LocationData.fromJson(Map<String, dynamic> json) => _$LocationDataFromJson(json);
  Map<String, dynamic> toJson() => _$LocationDataToJson(this);

  final String speed;
  final double lng;
  final double lat;
  final String name;
  final String isp;

}

@JsonSerializable()
class Locations {
  Locations({
    this.locationData
  });

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsToJson(this);

  final List<LocationData> locationData;
}

Future<Locations> getLocationData() async {
  // const googleLocationsURL = 'http://35c91e1e.ngrok.io/locationsRouter/locations';
  const googleLocationsURL = 'https://speedy-server.herokuapp.com/locationsRouter/locations';
  // forwarded localhost url from https://dashboard.ngrok.com/get-started
  // Retrieve the locations
  final response = await http.get(googleLocationsURL);
  
  if (response.statusCode == 200) {
    return Locations.fromJson(json.decode(response.body));
  } else {
    throw HttpException(
        'Unexpected status code ${response.statusCode}:'
        ' ${response.reasonPhrase}',
        uri: Uri.parse(googleLocationsURL));
  }
}
