// To parse this JSON data, do
//
//     final banksResponse = banksResponseFromJson(jsonString);

import 'dart:convert';

BanksResponse banksResponseFromJson(String str) =>
    BanksResponse.fromJson(json.decode(str));

String banksResponseToJson(BanksResponse data) => json.encode(data.toJson());

class BanksResponse {
  BanksResponse({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  bool? success;
  int? statusCode;
  String? message;
  List<Banks>? data;

  factory BanksResponse.fromJson(Map<String, dynamic> json) => BanksResponse(
        success: json["success"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: List<Banks>.from(json["data"].map((x) => Banks.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Banks {
  Banks({
    this.id,
    this.name,
    this.code,
  });

  int? id;
  String? name;
  String? code;

  Banks.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    code = json["code"];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
      };
}
