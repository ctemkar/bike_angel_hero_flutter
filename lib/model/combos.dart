import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:bike_angel_hero/services/location.dart';
import 'package:bike_angel_hero/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const nearDistance = 2; // 2 km
const combosURL = 'http://192.168.1.123:5000/getappcombos'; // testing
// const combosURL =
//    "https://bike-angel-hero-server.herokuapp.com/getappcombos"; // Production

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

class ComboListPage extends StatefulWidget {
  const ComboListPage({Key? key}) : super(key: key);

  @override
  _ComboListPageState createState() => _ComboListPageState();
}

class _ComboListPageState extends State<ComboListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("At: " + DateFormat('kk:mm:ss').format(DateTime.now())),
          leading: GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: Icon(
              Icons.menu, // add custom icons also
            ),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.search,
                    size: 26.0,
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.more_vert),
                )),
          ],
        ),
        body: FutureBuilder<List<Combo>>(
          future: _fetchCombos(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Combo>? data = snapshot.data;
              //createListView(context, snapshot);
              return RefreshIndicator(
                child: _combosListView(data),
                onRefresh: _fetchCombosWithStateRefresh,
              );
              // return _combosListView(data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const CircularProgressIndicator();
          },
        ));
  }

  Future<List<Combo>> _fetchCombosWithStateRefresh() {
    return _fetchCombos();
  }

  String formattedDate = '';
  Future<List<Combo>> _fetchCombos() async {
    MyLocation location = MyLocation();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(combosURL);
    DateTime now = DateTime.now();
    formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    final response = await networkHelper.getData();
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      for (int i = 0; i < jsonResponse.length; i++) {
        var element = jsonResponse[i];
        final distanceInMeters = calculateDistance(element['latitude'],
            element['longitude'], location.latitude, location.longitude);
        // print(distanceInMeters);
        if (distanceInMeters > nearDistance) {
          //     jsonResponse.removeAt(i);
        }
      }

      return jsonResponse.map((job) => Combo.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load combos from API');
    }
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    var distanceInKm = 12742 * asin(sqrt(a));
    // print(distanceInKm);
    return distanceInKm;
  }

  String formatSeconds(seconds) {
    int minutes = Duration(seconds: seconds).inMinutes;
    int remSeconds = seconds % 60;
    return (minutes).toString().padLeft(2, '0') +
        ': ' +
        remSeconds.toString().padLeft(2, '0');
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
        leading: CircleAvatar(
          backgroundColor: Colors.yellowAccent,
          child: Text(points.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              )),
        ),
        title: Text(pickupStation + ' \n' + dropoffStation,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            )),
        trailing: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.blue,
          child: Text(walktime.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              )),
        ),
      );
}
