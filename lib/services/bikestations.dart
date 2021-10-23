// To parse this JSON data, do
//
//     final bikeStations = bikeStationsFromJson(jsonString);

import 'dart:convert';

BikeStations bikeStationsFromJson(String str) =>
    BikeStations.fromJson(json.decode(str));

String bikeStationsToJson(BikeStations data) => json.encode(data.toJson());

class BikeStations {
  BikeStations({
    required this.type,
    required this.features,
  });

  final String? type;
  final List<Feature>? features;

  factory BikeStations.fromJson(Map<String, dynamic> json) => BikeStations(
        type: json["type"],
        features: json["features"] == null
            ? null
            : List<Feature>.from(
                json["features"].map((x) => Feature.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "features": features == null
            ? null
            : List<dynamic>.from(features!.map((x) => x.toJson())),
      };
}

class Feature {
  Feature({
    required this.type,
    required this.geometry,
    required this.properties,
  });

  final FeatureType? type;
  final Geometry? geometry;
  final Properties? properties;

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
        "type": type == null ? null : featureTypeValues.reverse![type!],
        "geometry": geometry == null ? null : geometry!.toJson(),
        "properties": properties == null ? null : properties!.toJson(),
      };
}

class Geometry {
  Geometry({
    required this.type,
    required this.coordinates,
  });

  final GeometryType? type;
  final List<double>? coordinates;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type:
            json["type"] == null ? null : geometryTypeValues.map[json["type"]],
        coordinates: json["coordinates"] == null
            ? null
            : List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : geometryTypeValues.reverse![type!],
        "coordinates": coordinates == null
            ? null
            : List<dynamic>.from(coordinates!.map((x) => x)),
      };
}

enum GeometryType { point }

final geometryTypeValues = EnumValues({"Point": GeometryType.point});

class Properties {
  Properties({
    required this.stationId,
    required this.name,
    required this.terminal,
    required this.capacity,
    required this.bikesAvailable,
    required this.docksAvailable,
    required this.bikesDisabled,
    required this.docksDisabled,
    required this.renting,
    required this.returning,
    required this.ebikeSurchargeWaiver,
    required this.installed,
    required this.lastReported,
    required this.iconPinBikeLayer,
    required this.iconPinDockLayer,
    required this.iconDotBikeLayer,
    required this.iconDotDockLayer,
    required this.bikeAngelsAction,
    required this.bikeAngelsPoints,
    required this.bikeAngelsDigits,
    required this.valetStatus,
    required this.ebikesAvailable,
    required this.ebikes,
    required this.sponsorName,
    required this.sponsorImageUrl,
    required this.sponsorLinkOutUrl,
    required this.valetSummary,
    required this.valetDescription,
    required this.valetSchedule,
    required this.valetLink,
  });

  final String? stationId;
  final String? name;
  final String? terminal;
  final int? capacity;
  final int? bikesAvailable;
  final int? docksAvailable;
  final int? bikesDisabled;
  final int? docksDisabled;
  final bool? renting;
  final bool? returning;
  final bool? ebikeSurchargeWaiver;
  final bool? installed;
  final int? lastReported;
  final IconPinBikeLayer? iconPinBikeLayer;
  final IconPinDockLayer? iconPinDockLayer;
  final IconDotLayer? iconDotBikeLayer;
  final IconDotLayer? iconDotDockLayer;
  final BikeAngelsAction? bikeAngelsAction;
  final int? bikeAngelsPoints;
  final int? bikeAngelsDigits;
  final ValetStatus? valetStatus;
  final int? ebikesAvailable;
  final List<Ebike>? ebikes;
  final SponsorName? sponsorName;
  final String? sponsorImageUrl;
  final String? sponsorLinkOutUrl;
  final ValetSummary? valetSummary;
  final String? valetDescription;
  final String? valetSchedule;
  final String? valetLink;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        stationId: json["station_id"],
        name: json["name"],
        terminal: json["terminal"],
        capacity: json["capacity"],
        bikesAvailable: json["bikes_available"],
        docksAvailable: json["docks_available"],
        bikesDisabled: json["bikes_disabled"],
        docksDisabled: json["docks_disabled"],
        renting: json["renting"],
        returning: json["returning"],
        ebikeSurchargeWaiver: json["ebike_surcharge_waiver"],
        installed: json["installed"],
        lastReported: json["last_reported"],
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
        bikeAngelsPoints: json["bike_angels_points"],
        bikeAngelsDigits: json["bike_angels_digits"],
        valetStatus: json["valet_status"] == null
            ? null
            : valetStatusValues.map[json["valet_status"]],
        ebikesAvailable: json["ebikes_available"],
        ebikes: json["ebikes"] == null
            ? null
            : List<Ebike>.from(json["ebikes"].map((x) => Ebike.fromJson(x))),
        sponsorName: json["sponsor_name"] == null
            ? null
            : sponsorNameValues.map[json["sponsor_name"]],
        sponsorImageUrl: json["sponsor_image_url"],
        sponsorLinkOutUrl: json["sponsor_link_out_url"],
        valetSummary: json["valet_summary"] == null
            ? null
            : valetSummaryValues.map[json["valet_summary"]],
        valetDescription: json["valet_description"],
        valetSchedule: json["valet_schedule"],
        valetLink: json["valet_link"],
      );

  Map<String, dynamic> toJson() => {
        "station_id": stationId,
        "name": name,
        "terminal": terminal,
        "capacity": capacity,
        "bikes_available": bikesAvailable,
        "docks_available": docksAvailable,
        "bikes_disabled": bikesDisabled,
        "docks_disabled": docksDisabled,
        "renting": renting,
        "returning": returning,
        "ebike_surcharge_waiver": ebikeSurchargeWaiver,
        "installed": installed,
        "last_reported": lastReported,
        "icon_pin_bike_layer": iconPinBikeLayer == null
            ? null
            : iconPinBikeLayerValues.reverse![iconPinBikeLayer!],
        "icon_pin_dock_layer": iconPinDockLayer == null
            ? null
            : iconPinDockLayerValues.reverse![iconPinDockLayer!],
        "icon_dot_bike_layer": iconDotBikeLayer == null
            ? null
            : iconDotLayerValues.reverse![iconDotBikeLayer!],
        "icon_dot_dock_layer": iconDotDockLayer == null
            ? null
            : iconDotLayerValues.reverse![iconDotDockLayer!],
        "bike_angels_action": bikeAngelsAction == null
            ? null
            : bikeAngelsActionValues.reverse![bikeAngelsAction!],
        "bike_angels_points": bikeAngelsPoints,
        "bike_angels_digits": bikeAngelsDigits,
        "valet_status": valetStatus == null
            ? null
            : valetStatusValues.reverse![valetStatus!],
        "ebikes_available": ebikesAvailable,
        "ebikes": ebikes == null
            ? null
            : List<dynamic>.from(ebikes!.map((x) => x.toJson())),
        "sponsor_name": sponsorName == null
            ? null
            : sponsorNameValues.reverse![sponsorName!],
        "sponsor_image_url": sponsorImageUrl,
        "sponsor_link_out_url": sponsorLinkOutUrl,
        "valet_summary": valetSummary == null
            ? null
            : valetSummaryValues.reverse![valetSummary!],
        "valet_description": valetDescription,
        "valet_schedule": valetSchedule,
        "valet_link": valetLink,
      };
}

enum BikeAngelsAction { give, take, neutral }

final bikeAngelsActionValues = EnumValues({
  "give": BikeAngelsAction.give,
  "neutral": BikeAngelsAction.neutral,
  "take": BikeAngelsAction.take
});

class Ebike {
  Ebike({
    required this.bikeNumber,
    required this.charge,
  });

  final String? bikeNumber;
  final int? charge;

  factory Ebike.fromJson(Map<String, dynamic> json) => Ebike(
        bikeNumber: json["bike_number"],
        charge: json["charge"],
      );

  Map<String, dynamic> toJson() => {
        "bike_number": bikeNumber,
        "charge": charge,
      };
}

enum IconDotLayer { dotYellow, dotGreen, dotPinValet, dotRed, dotGrey }

final iconDotLayerValues = EnumValues({
  "dot-green": IconDotLayer.dotGreen,
  "dot-grey": IconDotLayer.dotGrey,
  "dot-pin-valet": IconDotLayer.dotPinValet,
  "dot-red": IconDotLayer.dotRed,
  "dot-yellow": IconDotLayer.dotYellow
});

enum IconPinBikeLayer {
  pinBikeYellow,
  pinBikeGreenAll,
  pinBikeGreenMost,
  pinBikeGreenHalf,
  pinValet,
  pinBikeRed,
  pinBikeGrey
}

final iconPinBikeLayerValues = EnumValues({
  "pin-bike-green-all": IconPinBikeLayer.pinBikeGreenAll,
  "pin-bike-green-half": IconPinBikeLayer.pinBikeGreenHalf,
  "pin-bike-green-most": IconPinBikeLayer.pinBikeGreenMost,
  "pin-bike-grey": IconPinBikeLayer.pinBikeGrey,
  "pin-bike-red": IconPinBikeLayer.pinBikeRed,
  "pin-bike-yellow": IconPinBikeLayer.pinBikeYellow,
  "pin-valet": IconPinBikeLayer.pinValet
});

enum IconPinDockLayer {
  pinDockGreenMost,
  pinDockRed,
  pinDockYellow,
  pinDockGreenHalf,
  pinValet,
  pinDockGreenAll,
  pinDockGrey
}

final iconPinDockLayerValues = EnumValues({
  "pin-dock-green-all": IconPinDockLayer.pinDockGreenAll,
  "pin-dock-green-half": IconPinDockLayer.pinDockGreenHalf,
  "pin-dock-green-most": IconPinDockLayer.pinDockGreenMost,
  "pin-dock-grey": IconPinDockLayer.pinDockGrey,
  "pin-dock-red": IconPinDockLayer.pinDockRed,
  "pin-dock-yellow": IconPinDockLayer.pinDockYellow,
  "pin-valet": IconPinDockLayer.pinValet
});

enum SponsorName { healthFirst }

final sponsorNameValues = EnumValues({"Healthfirst": SponsorName.healthFirst});

enum ValetStatus { none, available }

final valetStatusValues =
    EnumValues({"available": ValetStatus.available, "none": ValetStatus.none});

enum ValetSummary { valetService }

final valetSummaryValues =
    EnumValues({"Valet Service": ValetSummary.valetService});

enum FeatureType { feature }

final featureTypeValues = EnumValues({"Feature": FeatureType.feature});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

// {"type": "Point", "coordinates": [-73.99392888, 40.76727216]}, "properties": {"bike_angels": {"score": 4}, "station": {"id": "72", "id_public": "66db237e-0aca-11e7-82f6-3863bb44ef7c", "name": "W 52 St & 11 Ave", "terminal": "6926.01", "installed": true, "last_reported": 1633218825, "ebike_surcharge_waiver": false, "accepts_dockable_bikes": true, "accepts_lockable_bikes": false, "capacity": 55, "bikes_available": 6, "docks_available": 49, "bikes_disabled": 0, "docks_disabled": 0, "renting": true, "returning": true}, "bikes": [], "icon_pin_bike_layer": "pin-bike-yellow", "icon_pin_dock_layer": "pin-dock-green-most", "icon_dot_bike_layer": "dot-yellow", "icon_dot_dock_layer": "dot-green", "bike_angels_action": "give", "bike_angels_points": 4, "bike_angels_digits": 1}}
