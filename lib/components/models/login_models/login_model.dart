// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

LoginModel? welcomeFromJson(String str) => LoginModel.fromJson(json.decode(str));

String welcomeToJson(LoginModel? data) => json.encode(data!.toJson());

class LoginModel {
  LoginModel({
    this.token,
    this.refreshToken,
    this.tokenInfo,
  });

  String? token;
  String? refreshToken;
  TokenInfo? tokenInfo;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    token: json["token"],
    refreshToken: json["refresh_token"],
    tokenInfo: TokenInfo.fromJson(json["token_info"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "refresh_token": refreshToken,
    "token_info": tokenInfo!.toJson(),
  };
}

class TokenInfo {
  TokenInfo({
    this.roles,
    this.userId,
    this.permissions,
    this.types,
    this.locationId,
    this.companyId,
  });

  List<String?>? roles;
  String? userId;
  List<int?>? permissions;
  Types? types;
  String? locationId;
  String? companyId;

  factory TokenInfo.fromJson(Map<String, dynamic> json) => TokenInfo(
    roles: json["roles"] == null ? [] : List<String?>.from(json["roles"]!.map((x) => x)),
    userId: json["user_id"],
    permissions: json["permissions"] == null ? [] : List<int?>.from(json["permissions"]!.map((x) => x)),
    types: Types.fromJson(json["types"]),
    locationId: json["location_id"],
    companyId: json["company_id"],
  );

  Map<String, dynamic> toJson() => {
    "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
    "user_id": userId,
    "permissions": permissions == null ? [] : List<dynamic>.from(permissions!.map((x) => x)),
    "types": types!.toJson(),
    "location_id": locationId,
    "company_id": companyId,
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
