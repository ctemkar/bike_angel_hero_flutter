import 'dart:convert';

import 'package:bike_angel_hero/services/bikestations.dart';
import 'package:bike_angel_hero/services/networking.dart';
import 'package:http/http.dart' as http;

const bikeAngelStationsDataURL =
    'https://layer.bicyclesharing.net/map/v1/nyc/stations';
// const combosURL = "http://192.168.1.123:5000/getappcombos"; // Testing
const combosURL =
    "https://bike-angel-hero-server.herokuapp.com/getappcombos"; // Production

class BikeAngelModel {
  Future<BikeStations> fetchBikeStations(http.Client client) async {
    NetworkHelper networkHelper = NetworkHelper(bikeAngelStationsDataURL);
    var response = await networkHelper.getData();
    final bikeStations = bikeStationsFromJson(response.body);
    return bikeStations;
  }

  Future<dynamic> getLocationStations() async {
    var resp = fetchBikeStations(http.Client());
    return resp;
  }

  // A function that converts a response body into a List<Photo>.
  List<BikeStations> parseBikeStations(String responseBody) {
    try {
      final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

      // var result = parsed
      //     .map<BikeStations>((json) => BikeStations.fromJson(json))
      //     .toList();
      return parsed
          .map<BikeStations>((json) => BikeStations.fromJson(json))
          .toList();
    } catch (e) {
      // print(e.toString());
      return List.empty();
    }
  }

  Future<List> fetchCombos(http.Client client) async {
    NetworkHelper networkHelper = NetworkHelper(combosURL);
    var response = await networkHelper.getData();
    final bikeStations = bikeStationsFromJson(response.body) as List;
    return bikeStations;
  }

  Future<List> getCombos() async {
    var resp = fetchCombos(http.Client());
    return resp;
  }
}
