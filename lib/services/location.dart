import 'package:flutter/foundation.dart';
import 'package:location/location.dart';

class MyLocation {
  late double latitude;
  late double longitude;

  Future<void> getCurrentLocation() async {
    // print('Getting location ...');
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    try {
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print("Platform exception calling serviceEnabled(): $err");
      }
      _serviceEnabled = false;
    }
    try {
      _locationData = await location.getLocation();
      latitude = _locationData.latitude!;
      longitude = _locationData.longitude!;
      // print('Lat: $_locationData');
    } catch (e) {
      // print(e);
    }
  }
}
