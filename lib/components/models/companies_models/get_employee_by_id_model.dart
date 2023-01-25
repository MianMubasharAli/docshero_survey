// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

GetEmployeeByIdModel welcomeFromJson(String str) => GetEmployeeByIdModel.fromJson(json.decode(str));

String welcomeToJson(GetEmployeeByIdModel data) => json.encode(data.toJson());

class GetEmployeeByIdModel {
  GetEmployeeByIdModel({
    required this.data,
    required this.count,
  });

  List<SingleEmployeeData> data;
  int count;

  factory GetEmployeeByIdModel.fromJson(Map<String, dynamic> json) => GetEmployeeByIdModel(
    data: List<SingleEmployeeData>.from(json["data"].map((x) => SingleEmployeeData.fromJson(x))),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "count": count,
  };
}

class SingleEmployeeData {
  SingleEmployeeData({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.city,
    this.zip,
    this.street,
    this.streetNumber,
    required this.mobile,
    required this.fax,
    required this.department,
    required this.position,
    required this.locationId,
    required this.companyId,
    required this.roles,
    this.creationDate,
    required this.types,
  });

  String? id;
  String? email;
  String? firstName;
  String? lastName;
  dynamic? city;
  dynamic? zip;
  dynamic? street;
  dynamic? streetNumber;
  String? mobile;
  String? fax;
  String? department;
  String? position;
  String? locationId;
  String? companyId;
  List<dynamic>? roles;
  dynamic? creationDate;
  Types? types;

  factory SingleEmployeeData.fromJson(Map<String, dynamic> json) => SingleEmployeeData(
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
    roles: List<dynamic>.from(json["roles"].map((x) => x)),
    creationDate: json["creation_date"],
    types: Types.fromJson(json["types"]),
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
    "roles": List<dynamic>.from(roles!.map((x) => x)),
    "creation_date": creationDate,
    "types": types?.toJson(),
  };
}

class Types {
  Types({
    required this.employee,
    required this.customerEmployee,
    required this.partnerEmployee,
  });

  int employee;
  int customerEmployee;
  int partnerEmployee;

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
