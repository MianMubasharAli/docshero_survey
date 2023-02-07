// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

GetAllSuppliersModel welcomeFromJson(String str) => GetAllSuppliersModel.fromJson(json.decode(str));

String welcomeToJson(GetAllSuppliersModel data) => json.encode(data.toJson());

class GetAllSuppliersModel {
  GetAllSuppliersModel({
    this.data,
    this.links,
    this.count,
  });

  List<SupplierData>? data;
  List<Link>? links;
  int? count;

  factory GetAllSuppliersModel.fromJson(Map<String, dynamic> json) => GetAllSuppliersModel(
    data: json["data"] == null ? [] : List<SupplierData>.from(json["data"]!.map((x) => SupplierData.fromJson(x))),
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "count": count,
  };
}

class SupplierData {
  SupplierData({
    this.id,
    this.supplierName,
    this.vatId,
    this.url,
    this.type,
    this.supplierType,
    this.supplierNumber,
  });

  String? id;
  String? supplierName;
  String? vatId;
  String? url;
  String? type;
  String? supplierType;
  String? supplierNumber;

  factory SupplierData.fromJson(Map<String, dynamic> json) => SupplierData(
    id: json["id"],
    supplierName: json["supplierName"],
    vatId: json["vatId"],
    url: json["url"],
    type: json["type"],
    supplierType: json["supplierType"],
    supplierNumber: json["supplierNumber"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "supplierName": supplierName,
    "vatId": vatId,
    "url": url,
    "type": type,
    "supplierType": supplierType,
    "supplierNumber": supplierNumber,
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
