import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../services/location/locations.dart' as locations;

class MapX extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapX> {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final locationDetails = await locations.getLocationData();
    setState(() {
      String data = "Colombo Sri Lanka Dialog Axiata";
      for (final location in locationDetails.locationData) {
        /// this will prompt an error in [locations.getLocationData]
        /// to overcome it change the url with your local url forwarded by ngrok
        /// ngrok: https://dashboard.ngrok.com/get-started
        final marker = Marker(
          markerId: MarkerId(location.name),
          position: LatLng(location.lat, location.lng),
          infoWindow: InfoWindow(
            title: location.speed,
            snippet: location.name,
            // snippet: data,
            
          ),
        );
        _markers[location.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: const LatLng(7.2906, 80.6337),
              zoom: 7,
            ),
            markers: _markers.values.toSet()));
  }
}
