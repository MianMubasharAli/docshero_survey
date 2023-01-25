import 'package:flutter/material.dart';

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

AllCompaniesModel? welcomeFromJson(String str) => AllCompaniesModel.fromJson(json.decode(str));

String welcomeToJson(AllCompaniesModel? data) => json.encode(data!.toJson());

class AllCompaniesModel {
  AllCompaniesModel({
    this.data,
    this.links,
    this.count,
  });

  List<Datum?>? data;
  List<Link?>? links;
  int? count;

  factory AllCompaniesModel.fromJson(Map<String, dynamic> json) => AllCompaniesModel(
    data: json["data"] == null ? [] : List<Datum?>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    links: json["links"] == null ? [] : List<Link?>.from(json["links"]!.map((x) => Link.fromJson(x))),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x!.toJson())),
    "count": count,
  };
}

class Datum {
  Datum({
    this.id,
    this.companyName,
    this.vatId,
    this.url,
    this.type,
    this.customerType,
    this.companyNumber,
  });

  String? id;
  String? companyName;
  String? vatId;
  String? url;
  String? type;
  String? customerType;
  String? companyNumber;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    companyName: json["companyName"],
    vatId: json["vatId"],
    url: json["url"],
    type: json["type"],
    customerType: json["customerType"],
    companyNumber: json["companyNumber"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "companyName": companyName,
    "vatId": vatId,
    "url": url,
    "type": type,
    "customerType": customerType,
    "companyNumber": companyNumber,
  };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
