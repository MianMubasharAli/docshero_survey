// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

SingleCompanyDataModel welcomeFromJson(String str) => SingleCompanyDataModel.fromJson(json.decode(str));

String welcomeToJson(SingleCompanyDataModel data) => json.encode(data.toJson());

class SingleCompanyDataModel {
  SingleCompanyDataModel({
    required this.modelData,
  });

  ModelData? modelData;

  factory SingleCompanyDataModel.fromJson(Map<String, dynamic> json) => SingleCompanyDataModel(
    modelData: ModelData.fromJson(json["modelData"]),
  );

  Map<String, dynamic> toJson() => {
    "modelData": modelData?.toJson(),
  };
}

class ModelData {
  ModelData({
    required this.id,
    required this.companyName,
    required this.vatId,
    required this.url,
    required this.phone,
    this.fax,
    required this.type,
    required this.customerType,
  });

  String? id;
  String? companyName;
  String? vatId;
  String? url;
  String? phone;
  dynamic? fax;
  String? type;
  String? customerType;

  factory ModelData.fromJson(Map<String, dynamic> json) => ModelData(
    id: json["id"],
    companyName: json["companyName"],
    vatId: json["vatId"],
    url: json["url"],
    phone: json["phone"],
    fax: json["fax"],
    type: json["type"],
    customerType: json["customerType"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "companyName": companyName,
    "vatId": vatId,
    "url": url,
    "phone": phone,
    "fax": fax,
    "type": type,
    "customerType": customerType,
  };
}
