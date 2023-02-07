// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

TermsOfPaymentModel TermsOfPaymentModelFromJson(String str) => TermsOfPaymentModel.fromJson(json.decode(str));

String TermsOfPaymentModelToJson(TermsOfPaymentModel data) => json.encode(data.toJson());

class TermsOfPaymentModel {
  TermsOfPaymentModel({
    this.data,
    this.links,
    this.count,
  });

  List<TermsOfPaymentData>? data;
  List<Link>? links;
  int? count;

  factory TermsOfPaymentModel.fromJson(Map<String, dynamic> json) => TermsOfPaymentModel(
    data: json["data"] == null ? [] : List<TermsOfPaymentData>.from(json["data"]!.map((x) => TermsOfPaymentData.fromJson(x))),
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "count": count,
  };
}

class TermsOfPaymentData {
  TermsOfPaymentData({
    this.id,
    this.noOfDays1,
    this.percentage1,
    this.noOfDays2,
    this.percentage2,
    this.percentage3,
    this.ownExplanation,
    this.salesText,
    this.paymentTerms,
  });

  int? id;
  int? noOfDays1;
  int? percentage1;
  int? noOfDays2;
  int? percentage2;
  int? percentage3;
  String? ownExplanation;
  String? salesText;
  String? paymentTerms;

  factory TermsOfPaymentData.fromJson(Map<String, dynamic> json) => TermsOfPaymentData(
    id: json["id"],
    noOfDays1: json["noOfDays1"],
    percentage1: json["percentage1"],
    noOfDays2: json["noOfDays2"],
    percentage2: json["percentage2"],
    percentage3: json["percentage3"],
    ownExplanation: json["ownExplanation"],
    salesText: json["salesText"],
    paymentTerms: json["paymentTerms"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "noOfDays1": noOfDays1,
    "percentage1": percentage1,
    "noOfDays2": noOfDays2,
    "percentage2": percentage2,
    "percentage3": percentage3,
    "ownExplanation": ownExplanation,
    "salesText": salesText,
    "paymentTerms": paymentTerms,
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
