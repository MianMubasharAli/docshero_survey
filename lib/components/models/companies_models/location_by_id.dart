// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

LocationByIdModel? welcomeFromJson(String str) => LocationByIdModel.fromJson(json.decode(str));

String welcomeToJson(LocationByIdModel? data) => json.encode(data!.toJson());

class LocationByIdModel {
  LocationByIdModel({
    this.success,
    this.locations,
  });

  bool? success;
  List<Location?>? locations;

  factory LocationByIdModel.fromJson(Map<String, dynamic> json) => LocationByIdModel(
    success: json["success"],
    locations: json["locations"] == null ? [] : List<Location?>.from(json["locations"]!.map((x) => Location.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "locations": locations == null ? [] : List<dynamic>.from(locations!.map((x) => x!.toJson())),
  };
}

class Location {
  Location({
    this.id,
    this.addressFirst,
    this.addressSecond,
    this.zip,
    this.companyId,
    this.city,
    this.country,
    this.state,
    this.isHeadQuarters,
  });

  String? id;
  String? addressFirst;
  dynamic addressSecond;
  String? zip;
  dynamic companyId;
  String? city;
  String? country;
  String? state;
  int? isHeadQuarters;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json["id"],
    addressFirst: json["addressFirst"],
    addressSecond: json["addressSecond"],
    zip: json["zip"],
    companyId: json["companyId"],
    city: json["city"],
    country: json["country"],
    state: json["state"],
    isHeadQuarters: json["isHeadQuarters"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "addressFirst": addressFirst,
    "addressSecond": addressSecond,
    "zip": zip,
    "companyId": companyId,
    "city": city,
    "country": country,
    "state": state,
    "isHeadQuarters": isHeadQuarters,
  };
}
