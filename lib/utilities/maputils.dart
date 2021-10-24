import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  static Future<void> openMapWithDirections(
      String pickup, String dropoff) async {
    var origin = Uri.encodeComponent("Citi Bike: " + pickup);
    var destination = Uri.encodeComponent("Citi Bike: " + dropoff);

    var directionLink = googleMapsDirectionsUrl +
        "&origin=" +
        origin +
        "&destination=" +
        destination;
    if (Platform.isIOS) {
      directionLink =
          appleMapsDirectionsUrl + "&saddr=" + origin + "&daddr=" + destination;
    }

    if (await canLaunch(directionLink)) {
      await launch(directionLink);
    } else {
      throw 'Could not open the map.';
    }
  }
}
