import 'dart:convert';

import 'package:bike_angel_hero/services/bikestations.dart';
import 'package:bike_angel_hero/services/networking.dart';
import 'package:http/http.dart' as http;

const bikeAngelStationsDataURL =
    'https://layer.bicyclesharing.net/map/v1/nyc/stations';

class BikeAngelModel {
  Future<BikeStations> fetchBikeStations(http.Client client) async {
    // final response = await client.get(Uri.parse(bikeAngelStationsDataURL));
    NetworkHelper networkHelper = NetworkHelper(bikeAngelStationsDataURL);
    var response = await networkHelper.getData();
    //var parsedData = parseBikeStations(response.body);
    final bikeStations = bikeStationsFromJson(response.body);
    //return parseBikeStations(response.body);
    return bikeStations;
  }
  // Future<dynamic> getStations(String cityName) async {
  //   NetworkHelper networkHelper = NetworkHelper(bikeAngelStationsDataURL);
  //   var bikeStationsData = await networkHelper.getData();
  //   print(bikeStationsData);
  //   return bikeStationsData;
  // }

  Future<dynamic> getLocationStations() async {
    // MyLocation location = MyLocation();
    // await location.getCurrentLocation();
    var resp = fetchBikeStations(http.Client());
    // print(resp);
    return resp;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  // A function that converts a response body into a List<Photo>.
  List<BikeStations> parseBikeStations(String responseBody) {
    try {
      final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

      var result = parsed
          .map<BikeStations>((json) => BikeStations.fromJson(json))
          .toList();
      return parsed
          .map<BikeStations>((json) => BikeStations.fromJson(json))
          .toList();
    } catch (e) {
      print(e.toString());
      return List.empty();
    }
  }
}

// class Model {
//   var station_id, coordinates;
//
//   Model._({this.coordinates, this.station_id});
//
//   factory Model.fromJson(Map<String, dynamic> json) {
//     return new Model._(
//       coordinates: json['coordinates'],
//       station_id: json['properties']['station_id'],
//     );
//   }
// }
