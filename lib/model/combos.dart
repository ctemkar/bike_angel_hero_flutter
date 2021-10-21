import 'dart:async';
import 'dart:convert';

import 'package:bike_angel_hero/services/networking.dart';
import 'package:flutter/material.dart';

class Combo {
  late final int points;
  late final int distance;
  late final int walkTime;
  late final String pickupStation;
  late final String dropoffStation;

  Combo(
      {required this.points,
      required this.distance,
      required this.walkTime,
      required this.pickupStation,
      required this.dropoffStation});

  factory Combo.fromJson(Map<String, dynamic> json) {
    return Combo(
      points: json['angel_points'],
      distance: json['google_distance'],
      walkTime: json['walking_time'],
      pickupStation: json['pickup_from'],
      dropoffStation: json['dropoff_to'],
    );
  }
}

class CombosListView extends StatelessWidget {
  const CombosListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Combo>>(
      future: _fetchCombos(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Combo>? data = snapshot.data;
          return _combosListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<List<Combo>> _fetchCombos() async {
    const combosURL = 'http://192.168.1.123:5000/getappcombos';
    NetworkHelper networkHelper = NetworkHelper(combosURL);
    final response = await networkHelper.getData();

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => Combo.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load combos from API');
    }
  }

  ListView _combosListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _tile(
            data[index].points,
            data[index].distance,
            data[index].walkTime,
            data[index].pickupStation.toString(),
            data[index].dropoffStation.toString(),
          );
        });
  }

  ListTile _tile(int points, int distance, int walktime, String pickupStation,
          String dropoffStation) =>
      ListTile(
        title: Text(
            points.toString() +
                '   ' +
                distance.toString() +
                '   ' +
                walktime.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(pickupStation + ' - ' + dropoffStation,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
            )),
      );
}
