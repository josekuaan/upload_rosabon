// To parse this JSON data, do
//
//     final myreferalResponse = myreferalResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

MyreferalResponse myreferalResponseFromJson(String str) =>
    MyreferalResponse.fromJson(json.decode(str));

String myreferalResponseToJson(MyreferalResponse data) =>
    json.encode(data.toJson());

class MyreferalResponse extends BaseResponse {
  MyreferalResponse({this.referals, message, baseStatus})
      : super(baseStatus: baseStatus, message: message);

  List<Referal>? referals;

  factory MyreferalResponse.fromJson(Map<String, dynamic> json) =>
      MyreferalResponse(
          referals: List<Referal>.from(
              json["referals"].map((x) => Referal.fromJson(x))),
          baseStatus: json["baseStatus"] ?? true,
          message: json["message"] ?? '');

  Map<String, dynamic> toJson() => {
        "referals": List<dynamic>.from(referals!.map((x) => x.toJson())),
        "message": message,
        "baseStatus": baseStatus,
      };
}

class Referal {
  Referal({
    this.id,
    this.customerName,
    this.status,
    this.dateOfReg,
  });

  int? id;
  String? customerName;
  String? status;
  String? dateOfReg;

  Referal.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    if (json["customerName"] != null) {
      customerName = json["customerName"];
    }
    if (json["status"] != null) {
      status = json["status"];
    }
    if (json["dateOfReg"] != null) {
      dateOfReg = json["dateOfReg"];
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "customerName": customerName,
        "status": status,
        "dateOfReg": dateOfReg,
      };
}
