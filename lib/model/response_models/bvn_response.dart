// To parse this JSON data, do
//
//     final bvnResponse = bvnResponseFromJson(jsonString);

import 'dart:convert';

BvnResponse bvnResponseFromJson(String str) =>
    BvnResponse.fromJson(json.decode(str));

String bvnResponseToJson(BvnResponse data) => json.encode(data.toJson());

class BvnResponse {
  BvnResponse({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  factory BvnResponse.fromJson(Map<String, dynamic> json) => BvnResponse(
        success: json["success"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.status,
    this.firstName,
    this.middleName,
    this.lastName,
    this.mobile,
    this.dateOfBirth,
    this.idNumber,
    this.gender,
  });

  String? status;
  String? firstName;
  String? middleName;
  String? lastName;
  String? mobile;
  DateTime? dateOfBirth;
  String? idNumber;
  String? gender;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        firstName: json["firstName"],
        middleName: json["middleName"],
        lastName: json["lastName"],
        mobile: json["mobile"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        idNumber: json["idNumber"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "mobile": mobile,
        "dateOfBirth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "idNumber": idNumber,
        "gender": gender,
      };
}
