part of 'locations.dart';

LocationData _$LocationDataFromJson(Map<String, dynamic> json) {
  return LocationData(
      speed: json['speed'] as String,
      lat: double.parse(json['lat']),
      lng: double.parse(json['lng']),
      name: json['name'] as String,
  );
}

Map<String, dynamic> _$LocationDataToJson(LocationData instance) => <String, dynamic>{
  'lat': instance.lat,
  'lng': instance.lng,
  'name': instance.name,
  'speed': instance.speed,
};

Locations _$LocationsFromJson(Map<String, dynamic> json) {
  return Locations(
      locationData: (json['data'] as List)
          ?.map((e) =>
              e == null ? null : LocationData.fromJson(e as Map<String, dynamic>))
          ?.toList()
      );
}

Map<String, dynamic> _$LocationsToJson(Locations instance) =>
    <String, dynamic>{
      'locationData': instance.locationData,
    };
