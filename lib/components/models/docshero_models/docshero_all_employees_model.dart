// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

DocsheroAllEmployeesModel welcomeFromJson(String str) => DocsheroAllEmployeesModel.fromJson(json.decode(str));

String welcomeToJson(DocsheroAllEmployeesModel data) => json.encode(data.toJson());

class DocsheroAllEmployeesModel {
  DocsheroAllEmployeesModel({
    this.data,
    this.count,
  });

  List<DocsheroAllEmployeeData>? data;
  int? count;

  factory DocsheroAllEmployeesModel.fromJson(Map<String, dynamic> json) => DocsheroAllEmployeesModel(
    data: json["data"] == null ? [] : List<DocsheroAllEmployeeData>.from(json["data"]!.map((x) => DocsheroAllEmployeeData.fromJson(x))),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "count": count,
  };
}

class DocsheroAllEmployeeData {
  DocsheroAllEmployeeData({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.city,
    this.zip,
    this.street,
    this.streetNumber,
    this.mobile,
    this.fax,
    this.department,
    this.position,
    this.locationId,
    this.companyId,
    this.roles,
    this.creationDate,
    this.types,
  });

  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? city;
  String? zip;
  String? street;
  String? streetNumber;
  String? mobile;
  String? fax;
  String? department;
  String? position;
  String? locationId;
  String? companyId;
  List<String>? roles;
  dynamic creationDate;
  Types? types;

  factory DocsheroAllEmployeeData.fromJson(Map<String, dynamic> json) => DocsheroAllEmployeeData(
    id: json["id"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    city: json["city"],
    zip: json["zip"],
    street: json["street"],
    streetNumber: json["street_number"],
    mobile: json["mobile"],
    fax: json["fax"],
    department: json["department"],
    position: json["position"],
    locationId: json["location_id"],
    companyId: json["company_id"],
    roles: json["roles"] == null ? [] : List<String>.from(json["roles"]!.map((x) => x)),
    creationDate: json["creation_date"],
    types: json["types"] == null ? null : Types.fromJson(json["types"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "city": city,
    "zip": zip,
    "street": street,
    "street_number": streetNumber,
    "mobile": mobile,
    "fax": fax,
    "department": department,
    "position": position,
    "location_id": locationId,
    "company_id": companyId,
    "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
    "creation_date": creationDate,
    "types": types?.toJson(),
  };
}

class Types {
  Types({
    this.employee,
    this.customerEmployee,
    this.partnerEmployee,
  });

  int? employee;
  int? customerEmployee;
  int? partnerEmployee;

  factory Types.fromJson(Map<String, dynamic> json) => Types(
    employee: json["employee"],
    customerEmployee: json["customer_employee"],
    partnerEmployee: json["partner_employee"],
  );

  Map<String, dynamic> toJson() => {
    "employee": employee,
    "customer_employee": customerEmployee,
    "partner_employee": partnerEmployee,
  };
}
