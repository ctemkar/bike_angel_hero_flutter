import 'dart:typed_data';
import 'dart:ui';

import 'package:bike_angel_hero/model/bikeangelmodel.dart';
import 'package:bike_angel_hero/services/bikestations.dart';
import 'package:bike_angel_hero/services/location.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowMap extends StatefulWidget {
  const ShowMap({Key? key}) : super(key: key);

  @override
  _ShowMapState createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
  late GoogleMapController mapController;

  LatLng _center = const LatLng(40.760840, -73.998760);
  double latitude = 40.760840;
  double longitude = -73.998760;
  late GoogleMapController _controller;
  final Map<String, Marker> _markers = {};
  late Marker marker;
  @override
  void initState() {
    super.initState();
  }

  Future<void> _onMapCreated(GoogleMapController _cntlr) async {
    _controller = _cntlr;

//    getLocationData(latLngBounds);
  }

  Future<void> cameraMoveEvent() async {
    LatLngBounds latLngBounds = await _controller.getVisibleRegion();
    getLocationData(latLngBounds);
  }

  Future<bool> getLocationData(LatLngBounds visibleRegion) async {
    MyLocation location = MyLocation();
    await location.getCurrentLocation();
    _center = LatLng(location.latitude, location.longitude);
    var bikeStations = await BikeAngelModel().getLocationStations();
    int count = 1;
    BitmapDescriptor myIcon;

    var stationList = bikeStations.features;
    final Uint8List markerIcon = await getBytesFromCanvas(
        400, 400, 0, Colors.black26, Colors.white, false);

    _markers.clear();
    // _markers.add(marker);
    Color color;
    Color textColor;
    bool hasBigPoints;
    myIcon = BitmapDescriptor.fromBytes(markerIcon);

    for (var station in stationList) {
      hasBigPoints = false;
      var bikeAngelsAction = station.properties.bikeAngelsAction;
      var bikeAngelPoints = station.properties.bikeAngelsPoints;
      if (bikeAngelsAction == BikeAngelsAction.give) {
        bikeAngelPoints = -bikeAngelPoints;
      }
      double lat = station.geometry.coordinates[1];
      double lon = station.geometry.coordinates[0];
      String streetName = station.properties.name;
/*
      if (bikeAngelPoints != null) {
        if(bikeAngelPoints < 0) {
          continue;
        }
      }

*/
      if (bikeAngelsAction != null && visibleRegion.contains(LatLng(lat, lon)))
      //isNearMe(station.geometry.coordinates[1],
      // station.geometry.coordinates[0]))
      {
        textColor = Colors.white;
        color = Colors.black54;

        switch (bikeAngelPoints) {
          case 4:
            {
              color = Colors.red;
              hasBigPoints = true;
            }
            break;
          case 3:
            {
              color = Colors.deepOrangeAccent;
            }
            break;
          case 2:
            {
              color = Colors.purple;
            }
            break;

          case 1:
            {
              color = Colors.deepOrangeAccent;
            }
            break;

          case 0:
            {
              textColor = Colors.black54;
              // color = Colors.green;
              color = Colors.white;
            }
            break;

          case -1:
            {
              textColor = Colors.black;
              color = Colors.yellow;
            }
            break;

          case -2:
            {
              textColor = Colors.black;
              color = Colors.lime;
            }
            break;
          case -3:
            {
              textColor = Colors.black;
              color = Colors.blue;
            }
            break;

          case -4:
            {
              hasBigPoints = true;
              textColor = Colors.black;
              color = Colors.tealAccent;
            }
            break;
        }
        final Uint8List markerIcon = await getBytesFromCanvas(
            400, 200, bikeAngelPoints, color, textColor, hasBigPoints);
        myIcon = BitmapDescriptor.fromBytes(markerIcon);

        final marker = Marker(
          markerId: MarkerId(count.toString()),
          position: LatLng(lat, lon),
          icon: myIcon,
          infoWindow: InfoWindow(
            title: bikeAngelPoints.toString(),
            snippet: streetName,
          ),
        );
        setState(() {
          print(bikeAngelPoints);
          if(bikeAngelPoints >= 0) {
            _markers[count.toString()] = marker;
          }

        });
        count++;
      }
    }
    // print(_markers);
    return true;
  }

  bool isNearMe(double lat, double lon) {
    if ((latitude - lat).abs() < .01 && (longitude - lon).abs() < .01) {
      // count++;
      return true;
    }
    return false;
  }

  Future<Uint8List> getBytesFromCanvas(
      int width,
      int height,
      int bikeAngelPoints,
      Color color,
      Color textColor,
      bool hasBigPoints) async {
    // color = Colors.white;
    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color = color;
    const Radius radius = Radius.circular(10.0);
    // width = 150;
    // height = 150;
    const textFontSize = 72.0;
    int arrowCodePoint;

    var zoomLevel = await _controller.getZoomLevel();
    width = (zoomLevel * 12).toInt();
    height = width ~/ 2;
    TextStyle textStyleOut = TextStyle(
        fontSize: textFontSize,
        color: textColor,
        fontFamily: FontAwesomeIcons.solidArrowAltCircleUp.fontFamily,
        package: FontAwesomeIcons.solidArrowAltCircleUp.fontPackage);

    TextStyle textStyle0 = TextStyle(
        fontSize: textFontSize,
        color: textColor,
        fontFamily: FontAwesomeIcons.dotCircle.fontFamily,
        package: FontAwesomeIcons.dotCircle.fontPackage);
    TextStyle textStyleIn = TextStyle(
        fontSize: textFontSize,
        color: textColor,
        fontFamily: FontAwesomeIcons.solidArrowAltCircleDown.fontFamily,
        package: FontAwesomeIcons.solidArrowAltCircleDown.fontPackage);
    TextStyle selTextStyle;
    selTextStyle = textStyle0;
    arrowCodePoint = FontAwesomeIcons.dotCircle.codePoint;
    if (bikeAngelPoints > 0) {
      selTextStyle = textStyleOut;
      arrowCodePoint = FontAwesomeIcons.solidArrowAltCircleUp.codePoint;
    } else if (bikeAngelPoints < 0) {
      selTextStyle = textStyleIn;
      arrowCodePoint = FontAwesomeIcons.solidArrowAltCircleDown.codePoint;
    }

    /*
    if (hasBigPoints) {
      canvas.drawOval(
          Rect.fromLTWH(
              0.0, 0.0, width.toDouble() * 1.25, width.toDouble() * 1.25),
          paint);
    } else {
*/
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0.0, 0.0, width.toDouble(), height.toDouble()),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        paint);
    // }

    TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    painter.text = TextSpan(
      text: String.fromCharCode(arrowCodePoint) + bikeAngelPoints.toString(),
      style: selTextStyle,
    );

/*
    painter.text = TextSpan(
      text: title,
      style: TextStyle(
          fontSize: 55.0, color: textColor, fontWeight: FontWeight.bold),
    );
    */
    painter.layout();
    painter.paint(
        canvas,
        Offset((width * 0.5) - painter.width * 0.5,
            (height * 0.5) - painter.height * 0.5));
    final img = await pictureRecorder
        .endRecording()
        .toImage((width).toInt(), (height).toInt());
    final data = await img.toByteData(format: ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Bike Locations'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          // mapType: MapType.normal,
          // myLocationEnabled: true,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 16.0,
          ),
          onCameraIdle: cameraMoveEvent,
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }
}
