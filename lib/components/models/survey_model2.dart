// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:docshero/components/models/step2_model.dart';
import 'package:docshero/components/models/styles_configuration2_model.dart';

import 'cart2_model.dart';

Welcome2 welcomeFromJson(String str) => Welcome2.fromJson(json.decode(str));

String welcomeToJson(Welcome2 data) => json.encode(data.toJson());

class Welcome2 {
  Welcome2({
    this.id,
    this.name,
    this.steps,
    this.cart,
    this.stylesConfiguration,
  });

  String? id;
  String? name;
  List<Step2>? steps;
  Cart2? cart;
  StylesConfiguration2? stylesConfiguration;

  factory Welcome2.fromJson(Map<String, dynamic> json) => Welcome2(
    id: json["id"],
    name: json["name"],
    steps: List<Step2>.from(json["steps"].map((x) => Step2.fromJson(x))),
    cart: Cart2.fromJson(json["cart"]),
    stylesConfiguration: StylesConfiguration2.fromJson(json["stylesConfiguration"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "steps": List<dynamic>.from(steps!.map((x) => x.toJson())),
    "cart": cart?.toJson(),
    "stylesConfiguration": stylesConfiguration?.toJson(),
  };
}




