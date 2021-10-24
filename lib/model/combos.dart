import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:bike_angel_hero/services/location.dart';
import 'package:bike_angel_hero/services/networking.dart';
import 'package:bike_angel_hero/utilities/constants.dart';
import 'package:bike_angel_hero/utilities/maputils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const nearDistance = 2; // 2 km

MyLocation location = MyLocation();
bool filterByLocation = false;
int selectedSort = 0; // Default sort by points and distance

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

  static const iconSize = 26.0;
  @override
  Widget build(BuildContext context) {
    Icon selectedLocationIcon = filterByLocation
        ? const Icon(
            Icons.location_off, // Icons.favorite
            color: Colors.blueAccent, // Colors.red
            size: iconSize,
          )
        : const Icon(
            Icons.location_on, // Icons.favorite
            color: Colors.blueAccent, // Colors.red
            size: iconSize,
          );
    Icon selectedSortIcon = selectedSort == 0
        ? const Icon(
            Icons.arrow_circle_up_rounded, // Icons.favorite
            color: Colors.blueAccent, //
            size: iconSize,
          )
        : const Icon(
            Icons.arrow_circle_down_rounded, // Icons.favorite
            color: Colors.redAccent, //
            size: iconSize,
          );

    return Scaffold(
        // drawer: Drawer(
        //   child: ListView(
        //     // Important: Remove any padding from the ListView.
        //     padding: EdgeInsets.zero,
        //     children: [
        //       const DrawerHeader(
        //         decoration: BoxDecoration(
        //           color: Colors.blue,
        //         ),
        //         child: Text('Bike Angel Hero'),
        //       ),
        //       ListTile(
        //         title: const Text('Map View'),
        //         onTap: () {
        //           Navigator.of(context)
        //               .push(MaterialPageRoute(builder: (context) => ShowMap()));
        //         },
        //       ),
        //       ListTile(
        //         title: const Text('List View'),
        //         onTap: () {
        //           Navigator.of(context).push(
        //               MaterialPageRoute(builder: (context) => ComboListPage()));
        //
        //           // ...
        //         },
        //       ),
        //     ],
        //   ),
        // ),
        appBar: AppBar(
          title: Text(DateFormat('kk:mm').format(DateTime.now())),
          actions: <Widget>[
            Padding(
              // Refresh
              padding: const EdgeInsets.only(right: 20.0),
              child: Container(
                child: Material(
                  child: InkWell(
                    child: const Icon(
                      Icons.refresh,
                      size: iconSize,
                    ),
                    onTap: () {
                      setState(() {});
                    },
                  ),
                  color: Colors.transparent,
                ),
                color: Colors.transparent,
              ),
            ),
            Padding(
              // Sort
              padding: const EdgeInsets.only(right: 20.0),
              child: Container(
                child: Material(
                  child: InkWell(
                    child: selectedSortIcon,
                    onTap: () {
                      if (selectedSort == 0) {
                        selectedSort = 1;
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Sorted by Walking time, Points')));
                      } else {
                        selectedSort = 0;
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Sorted by Points, Walking time')));
                      }
                      setState(() {});
                    },
                  ),
                  color: Colors.transparent,
                ),
                color: Colors.transparent,
              ),
            ),
            Padding(
              // Location
              padding: const EdgeInsets.only(right: 20.0),
              child: Container(
                child: Material(
                  child: InkWell(
                    child: selectedLocationIcon,
                    onTap: () async {
                      await location.getCurrentLocation();
                      filterByLocation = !filterByLocation;
                      if (filterByLocation) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Showing places close to you')));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Showing everything')));
                      }
                      setState(() {});
                    },
                  ),
                  color: Colors.transparent,
                ),
                color: Colors.transparent,
              ),
            ),
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
    await location.getCurrentLocation();
    var locationParams = "&lat=${location.latitude}&lon=${location.longitude}";
    var url = combosURL +
        "?sort=${selectedSort}" +
        (filterByLocation ? locationParams : "");
    NetworkHelper networkHelper = NetworkHelper(url);
    DateTime now = DateTime.now();
    formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    final response = await networkHelper.getData();
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
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
        onTap: () {
          MapUtils.openMapWithDirections(pickupStation, dropoffStation);
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: const BoxDecoration(
              border:
                  Border(right: BorderSide(width: 1.0, color: Colors.white24))),
          child: CircleAvatar(
            backgroundColor: Colors.yellowAccent,
            foregroundColor: Colors.red,
            maxRadius: 22,
            minRadius: 15,
            child: Text(points.toString(),
                style: const TextStyle(
                  // color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
          ),
        ),
        title: Text(pickupStation + ' \n' + dropoffStation,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            )),
        trailing: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: const BoxDecoration(
              border:
                  Border(right: BorderSide(width: 1.0, color: Colors.white24))),
          child: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            maxRadius: 24,
            minRadius: 15,
            child: Text(formatSeconds(walktime),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                )),
          ),
        ),
      );
}
