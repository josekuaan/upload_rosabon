// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse extends BaseResponse {
  LoginResponse(
      {this.email,
      this.resetPassword,
      this.creationSource,
      this.token,
      this.id,
      this.fullName,
      this.isKyc,
      this.role,
      this.virtualAccountNo,
      this.virtualAccountName,
      this.userType,
      message,
      baseStatus})
      : super(baseStatus: baseStatus, message: message);

  int? id;
  String? email;
  String? creationSource;
  String? token;
  String? fullName;
  String? virtualAccountNo;
  String? virtualAccountName;
  String? userType;
  bool? isKyc;
  Role? role;
  bool? resetPassword;

  LoginResponse.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    email = json["email"];
    token = json["token"];
    resetPassword = json['resetPassword'];
    creationSource = json["creationSource"];
    fullName = json["fullName"];
    virtualAccountNo = json["virtualAccountNo"] ?? "";
    virtualAccountName = json["virtualAccountName"] ?? "";
    isKyc = json["kyc"];
    if (json["userType"] != null) {
      userType = json["userType"];
    }
    role = Role.fromJson(json["role"]);
    baseStatus = json["baseStatus"] ?? true;
    message = json["message"] ?? '';
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "token": token,
        "fullName": fullName,
        "virtualAccountName": virtualAccountName,
        "virtualAccountNo": virtualAccountNo,
        "isKyc": isKyc,
        "userType": userType,
        "role": role!.toJson(),
        "message": message,
        "baseStatus": baseStatus,
      };
}

class Role {
  Role({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
