// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

SingleContactReportModel welcomeFromJson(String str) => SingleContactReportModel.fromJson(json.decode(str));

String welcomeToJson(SingleContactReportModel data) => json.encode(data.toJson());

class SingleContactReportModel {
  SingleContactReportModel({
    this.modelData,
  });

  ModelData? modelData;

  factory SingleContactReportModel.fromJson(Map<String, dynamic> json) => SingleContactReportModel(
    modelData: json["modelData"] == null ? null : ModelData.fromJson(json["modelData"]),
  );

  Map<String, dynamic> toJson() => {
    "modelData": modelData?.toJson(),
  };
}

class ModelData {
  ModelData({
    this.id,
    this.subject,
    this.text,
    this.type,
    this.priority,
    this.contactType,
    this.initiatedBy,
    this.companyId,
    this.categoryId,
    this.createdByEmployee,
    this.companyEmployees,
    this.employees,
  });

  int? id;
  String? subject;
  String? text;
  String? type;
  String? priority;
  String? contactType;
  String? initiatedBy;
  String? companyId;
  int? categoryId;
  String? createdByEmployee;
  List<String>? companyEmployees;
  List<String>? employees;

  factory ModelData.fromJson(Map<String, dynamic> json) => ModelData(
    id: json["id"],
    subject: json["subject"],
    text: json["text"],
    type: json["type"],
    priority: json["priority"],
    contactType: json["contactType"],
    initiatedBy: json["initiatedBy"],
    companyId: json["companyId"],
    categoryId: json["categoryId"],
    createdByEmployee: json["createdByEmployee"],
    companyEmployees: json["companyEmployees"] == null ? [] : List<String>.from(json["companyEmployees"]!.map((x) => x)),
    employees: json["employees"] == null ? [] : List<String>.from(json["employees"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subject": subject,
    "text": text,
    "type": type,
    "priority": priority,
    "contactType": contactType,
    "initiatedBy": initiatedBy,
    "companyId": companyId,
    "categoryId": categoryId,
    "createdByEmployee": createdByEmployee,
    "companyEmployees": companyEmployees == null ? [] : List<dynamic>.from(companyEmployees!.map((x) => x)),
    "employees": employees == null ? [] : List<dynamic>.from(employees!.map((x) => x)),
  };
}
