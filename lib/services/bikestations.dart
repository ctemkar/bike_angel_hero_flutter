// @dart=2.9

// To parse this JSON data, do
//
//     final bikeStations = bikeStationsFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

BikeStations bikeStationsFromJson(String str) =>
    BikeStations.fromJson(json.decode(str));

String bikeStationsToJson(BikeStations data) => json.encode(data.toJson());

class BikeStations {
  BikeStations({
    @required this.type,
    @required this.features,
  });

  final String type;
  final List<Feature> features;

  factory BikeStations.fromJson(Map<String, dynamic> json) => BikeStations(
        type: json["type"] == null ? null : json["type"],
        features: json["features"] == null
            ? null
            : List<Feature>.from(
                json["features"].map((x) => Feature.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "features": features == null
            ? null
            : List<dynamic>.from(features.map((x) => x.toJson())),
      };
}

class Feature {
  Feature({
    @required this.type,
    @required this.geometry,
    @required this.properties,
  });

  final FeatureType type;
  final Geometry geometry;
  final Properties properties;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        type: json["type"] == null ? null : featureTypeValues.map[json["type"]],
        geometry: json["geometry"] == null
            ? null
            : Geometry.fromJson(json["geometry"]),
        properties: json["properties"] == null
            ? null
            : Properties.fromJson(json["properties"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : featureTypeValues.reverse[type],
        "geometry": geometry == null ? null : geometry.toJson(),
        "properties": properties == null ? null : properties.toJson(),
      };
}

class Geometry {
  Geometry({
    @required this.type,
    @required this.coordinates,
  });

  final GeometryType type;
  final List<double> coordinates;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type:
            json["type"] == null ? null : geometryTypeValues.map[json["type"]],
        coordinates: json["coordinates"] == null
            ? null
            : List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : geometryTypeValues.reverse[type],
        "coordinates": coordinates == null
            ? null
            : List<dynamic>.from(coordinates.map((x) => x)),
      };
}

enum GeometryType { POINT }

final geometryTypeValues = EnumValues({"Point": GeometryType.POINT});

class Properties {
  Properties({
    @required this.stationId,
    @required this.name,
    @required this.terminal,
    @required this.capacity,
    @required this.bikesAvailable,
    @required this.docksAvailable,
    @required this.bikesDisabled,
    @required this.docksDisabled,
    @required this.renting,
    @required this.returning,
    @required this.ebikeSurchargeWaiver,
    @required this.installed,
    @required this.lastReported,
    @required this.iconPinBikeLayer,
    @required this.iconPinDockLayer,
    @required this.iconDotBikeLayer,
    @required this.iconDotDockLayer,
    @required this.bikeAngelsAction,
    @required this.bikeAngelsPoints,
    @required this.bikeAngelsDigits,
    @required this.valetStatus,
    @required this.ebikesAvailable,
    @required this.ebikes,
    @required this.sponsorName,
    @required this.sponsorImageUrl,
    @required this.sponsorLinkOutUrl,
    @required this.valetSummary,
    @required this.valetDescription,
    @required this.valetSchedule,
    @required this.valetLink,
  });

  final String stationId;
  final String name;
  final String terminal;
  final int capacity;
  final int bikesAvailable;
  final int docksAvailable;
  final int bikesDisabled;
  final int docksDisabled;
  final bool renting;
  final bool returning;
  final bool ebikeSurchargeWaiver;
  final bool installed;
  final int lastReported;
  final IconPinBikeLayer iconPinBikeLayer;
  final IconPinDockLayer iconPinDockLayer;
  final IconDotLayer iconDotBikeLayer;
  final IconDotLayer iconDotDockLayer;
  final BikeAngelsAction bikeAngelsAction;
  final int bikeAngelsPoints;
  final int bikeAngelsDigits;
  final ValetStatus valetStatus;
  final int ebikesAvailable;
  final List<Ebike> ebikes;
  final SponsorName sponsorName;
  final String sponsorImageUrl;
  final String sponsorLinkOutUrl;
  final ValetSummary valetSummary;
  final String valetDescription;
  final String valetSchedule;
  final String valetLink;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        stationId: json["station_id"] == null ? null : json["station_id"],
        name: json["name"] == null ? null : json["name"],
        terminal: json["terminal"] == null ? null : json["terminal"],
        capacity: json["capacity"] == null ? null : json["capacity"],
        bikesAvailable:
            json["bikes_available"] == null ? null : json["bikes_available"],
        docksAvailable:
            json["docks_available"] == null ? null : json["docks_available"],
        bikesDisabled:
            json["bikes_disabled"] == null ? null : json["bikes_disabled"],
        docksDisabled:
            json["docks_disabled"] == null ? null : json["docks_disabled"],
        renting: json["renting"] == null ? null : json["renting"],
        returning: json["returning"] == null ? null : json["returning"],
        ebikeSurchargeWaiver: json["ebike_surcharge_waiver"] == null
            ? null
            : json["ebike_surcharge_waiver"],
        installed: json["installed"] == null ? null : json["installed"],
        lastReported:
            json["last_reported"] == null ? null : json["last_reported"],
        iconPinBikeLayer: json["icon_pin_bike_layer"] == null
            ? null
            : iconPinBikeLayerValues.map[json["icon_pin_bike_layer"]],
        iconPinDockLayer: json["icon_pin_dock_layer"] == null
            ? null
            : iconPinDockLayerValues.map[json["icon_pin_dock_layer"]],
        iconDotBikeLayer: json["icon_dot_bike_layer"] == null
            ? null
            : iconDotLayerValues.map[json["icon_dot_bike_layer"]],
        iconDotDockLayer: json["icon_dot_dock_layer"] == null
            ? null
            : iconDotLayerValues.map[json["icon_dot_dock_layer"]],
        bikeAngelsAction: json["bike_angels_action"] == null
            ? null
            : bikeAngelsActionValues.map[json["bike_angels_action"]],
        bikeAngelsPoints: json["bike_angels_points"] == null
            ? null
            : json["bike_angels_points"],
        bikeAngelsDigits: json["bike_angels_digits"] == null
            ? null
            : json["bike_angels_digits"],
        valetStatus: json["valet_status"] == null
            ? null
            : valetStatusValues.map[json["valet_status"]],
        ebikesAvailable:
            json["ebikes_available"] == null ? null : json["ebikes_available"],
        ebikes: json["ebikes"] == null
            ? null
            : List<Ebike>.from(json["ebikes"].map((x) => Ebike.fromJson(x))),
        sponsorName: json["sponsor_name"] == null
            ? null
            : sponsorNameValues.map[json["sponsor_name"]],
        sponsorImageUrl: json["sponsor_image_url"] == null
            ? null
            : json["sponsor_image_url"],
        sponsorLinkOutUrl: json["sponsor_link_out_url"] == null
            ? null
            : json["sponsor_link_out_url"],
        valetSummary: json["valet_summary"] == null
            ? null
            : valetSummaryValues.map[json["valet_summary"]],
        valetDescription: json["valet_description"] == null
            ? null
            : json["valet_description"],
        valetSchedule:
            json["valet_schedule"] == null ? null : json["valet_schedule"],
        valetLink: json["valet_link"] == null ? null : json["valet_link"],
      );

  Map<String, dynamic> toJson() => {
        "station_id": stationId == null ? null : stationId,
        "name": name == null ? null : name,
        "terminal": terminal == null ? null : terminal,
        "capacity": capacity == null ? null : capacity,
        "bikes_available": bikesAvailable == null ? null : bikesAvailable,
        "docks_available": docksAvailable == null ? null : docksAvailable,
        "bikes_disabled": bikesDisabled == null ? null : bikesDisabled,
        "docks_disabled": docksDisabled == null ? null : docksDisabled,
        "renting": renting == null ? null : renting,
        "returning": returning == null ? null : returning,
        "ebike_surcharge_waiver":
            ebikeSurchargeWaiver == null ? null : ebikeSurchargeWaiver,
        "installed": installed == null ? null : installed,
        "last_reported": lastReported == null ? null : lastReported,
        "icon_pin_bike_layer": iconPinBikeLayer == null
            ? null
            : iconPinBikeLayerValues.reverse[iconPinBikeLayer],
        "icon_pin_dock_layer": iconPinDockLayer == null
            ? null
            : iconPinDockLayerValues.reverse[iconPinDockLayer],
        "icon_dot_bike_layer": iconDotBikeLayer == null
            ? null
            : iconDotLayerValues.reverse[iconDotBikeLayer],
        "icon_dot_dock_layer": iconDotDockLayer == null
            ? null
            : iconDotLayerValues.reverse[iconDotDockLayer],
        "bike_angels_action": bikeAngelsAction == null
            ? null
            : bikeAngelsActionValues.reverse[bikeAngelsAction],
        "bike_angels_points":
            bikeAngelsPoints == null ? null : bikeAngelsPoints,
        "bike_angels_digits":
            bikeAngelsDigits == null ? null : bikeAngelsDigits,
        "valet_status":
            valetStatus == null ? null : valetStatusValues.reverse[valetStatus],
        "ebikes_available": ebikesAvailable == null ? null : ebikesAvailable,
        "ebikes": ebikes == null
            ? null
            : List<dynamic>.from(ebikes.map((x) => x.toJson())),
        "sponsor_name":
            sponsorName == null ? null : sponsorNameValues.reverse[sponsorName],
        "sponsor_image_url": sponsorImageUrl == null ? null : sponsorImageUrl,
        "sponsor_link_out_url":
            sponsorLinkOutUrl == null ? null : sponsorLinkOutUrl,
        "valet_summary": valetSummary == null
            ? null
            : valetSummaryValues.reverse[valetSummary],
        "valet_description": valetDescription == null ? null : valetDescription,
        "valet_schedule": valetSchedule == null ? null : valetSchedule,
        "valet_link": valetLink == null ? null : valetLink,
      };
}

enum BikeAngelsAction { GIVE, TAKE, NEUTRAL }

final bikeAngelsActionValues = EnumValues({
  "give": BikeAngelsAction.GIVE,
  "neutral": BikeAngelsAction.NEUTRAL,
  "take": BikeAngelsAction.TAKE
});

class Ebike {
  Ebike({
    @required this.bikeNumber,
    @required this.charge,
  });

  final String bikeNumber;
  final int charge;

  factory Ebike.fromJson(Map<String, dynamic> json) => Ebike(
        bikeNumber: json["bike_number"] == null ? null : json["bike_number"],
        charge: json["charge"] == null ? null : json["charge"],
      );

  Map<String, dynamic> toJson() => {
        "bike_number": bikeNumber == null ? null : bikeNumber,
        "charge": charge == null ? null : charge,
      };
}

enum IconDotLayer { DOT_YELLOW, DOT_GREEN, DOT_PIN_VALET, DOT_RED, DOT_GREY }

final iconDotLayerValues = EnumValues({
  "dot-green": IconDotLayer.DOT_GREEN,
  "dot-grey": IconDotLayer.DOT_GREY,
  "dot-pin-valet": IconDotLayer.DOT_PIN_VALET,
  "dot-red": IconDotLayer.DOT_RED,
  "dot-yellow": IconDotLayer.DOT_YELLOW
});

enum IconPinBikeLayer {
  PIN_BIKE_YELLOW,
  PIN_BIKE_GREEN_ALL,
  PIN_BIKE_GREEN_MOST,
  PIN_BIKE_GREEN_HALF,
  PIN_VALET,
  PIN_BIKE_RED,
  PIN_BIKE_GREY
}

final iconPinBikeLayerValues = EnumValues({
  "pin-bike-green-all": IconPinBikeLayer.PIN_BIKE_GREEN_ALL,
  "pin-bike-green-half": IconPinBikeLayer.PIN_BIKE_GREEN_HALF,
  "pin-bike-green-most": IconPinBikeLayer.PIN_BIKE_GREEN_MOST,
  "pin-bike-grey": IconPinBikeLayer.PIN_BIKE_GREY,
  "pin-bike-red": IconPinBikeLayer.PIN_BIKE_RED,
  "pin-bike-yellow": IconPinBikeLayer.PIN_BIKE_YELLOW,
  "pin-valet": IconPinBikeLayer.PIN_VALET
});

enum IconPinDockLayer {
  PIN_DOCK_GREEN_MOST,
  PIN_DOCK_RED,
  PIN_DOCK_YELLOW,
  PIN_DOCK_GREEN_HALF,
  PIN_VALET,
  PIN_DOCK_GREEN_ALL,
  PIN_DOCK_GREY
}

final iconPinDockLayerValues = EnumValues({
  "pin-dock-green-all": IconPinDockLayer.PIN_DOCK_GREEN_ALL,
  "pin-dock-green-half": IconPinDockLayer.PIN_DOCK_GREEN_HALF,
  "pin-dock-green-most": IconPinDockLayer.PIN_DOCK_GREEN_MOST,
  "pin-dock-grey": IconPinDockLayer.PIN_DOCK_GREY,
  "pin-dock-red": IconPinDockLayer.PIN_DOCK_RED,
  "pin-dock-yellow": IconPinDockLayer.PIN_DOCK_YELLOW,
  "pin-valet": IconPinDockLayer.PIN_VALET
});

enum SponsorName { HEALTHFIRST }

final sponsorNameValues = EnumValues({"Healthfirst": SponsorName.HEALTHFIRST});

enum ValetStatus { NONE, AVAILABLE }

final valetStatusValues =
    EnumValues({"available": ValetStatus.AVAILABLE, "none": ValetStatus.NONE});

enum ValetSummary { VALET_SERVICE }

final valetSummaryValues =
    EnumValues({"Valet Service": ValetSummary.VALET_SERVICE});

enum FeatureType { FEATURE }

final featureTypeValues = EnumValues({"Feature": FeatureType.FEATURE});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
