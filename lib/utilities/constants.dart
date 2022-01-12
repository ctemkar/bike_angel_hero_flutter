import 'package:flutter/material.dart';

const String apiKey = 'a23c8ef65be625d9cb492de9bf53e72f';

const googleMapsDirectionsUrl =
    "https://www.google.com/maps/dir/?api=1&travelmode=bicycling";
const appleMapsDirectionsUrl = "http://maps.apple.com/?dirflg=w";
//const combosURL = 'http://192.168.1.123:5000/getappcombos'; // testing
const combosURL =
    "https://bike-angel-hero-server.herokuapp.com/getappcombos"; // Production
const nearDistance = 2; // 2 km

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

const kTextFeildInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: BorderSide.none),
);
