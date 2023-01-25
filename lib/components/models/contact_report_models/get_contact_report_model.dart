// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

GetContactReportModel welcomeFromJson(String str) => GetContactReportModel.fromJson(json.decode(str));

String welcomeToJson(GetContactReportModel data) => json.encode(data.toJson());

class GetContactReportModel {
  GetContactReportModel({
    required this.data,
    required this.links,
    required this.count,
  });

  List<ContactReportData> data;
  List<Link> links;
  int count;

  factory GetContactReportModel.fromJson(Map<String, dynamic> json) => GetContactReportModel(
    data: List<ContactReportData>.from(json["data"].map((x) => ContactReportData.fromJson(x))),
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "count": count,
  };
}

class ContactReportData {
  ContactReportData({
     this.id,
     this.subject,
     this.text,
     this.type,
     this.priority,
     this.contactType,
     this.initiatedBy,
  });

  int? id;
  String? subject;
  String? text;
  String? type;
  String? priority;
  String? contactType;
  String? initiatedBy;

  factory ContactReportData.fromJson(Map<String, dynamic> json) => ContactReportData(
    id: json["id"],
    subject: json["subject"],
    text: json["text"],
    type: json["type"],
    priority: json["priority"],
    contactType: json["contactType"],
    initiatedBy: json["initiatedBy"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subject": subject,
    "text": text,
    "type": type,
    "priority": priority,
    "contactType": contactType,
    "initiatedBy": initiatedBy,
  };
}

class Link {
  Link({
    this.url,
    required this.label,
    required this.active,
  });

  String? url;
  String label;
  bool active;

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
