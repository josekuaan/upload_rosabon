// To parse this JSON data, do
//
//     final genderResponse = genderResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

GenderResponse genderResponseFromJson(String str) =>
    GenderResponse.fromJson(json.decode(str));

String genderResponseToJson(GenderResponse data) => json.encode(data.toJson());

class GenderResponse extends BaseResponse {
  GenderResponse({this.gender, message, baseStatus})
      : super(baseStatus: baseStatus, message: message);

  List<Gender>? gender;

  factory GenderResponse.fromJson(Map<String, dynamic> json) => GenderResponse(
      gender: List<Gender>.from(json["gender"].map((x) => Gender.fromJson(x))),
      message: json["message"] ?? "",
      baseStatus: json["baseStatus"] ?? true);

  Map<String, dynamic> toJson() => {
        "gender": List<dynamic>.from(gender!.map((x) => x.toJson())),
        "message": message,
        "baseStatus": baseStatus,
      };
}

class Gender {
  Gender({
    this.id,
    this.gender,
    this.description,
    this.status,
    this.createdAt,
  });

  int? id;
  String? gender;
  String? description;
  String? status;
  String? createdAt;

  Gender.fromJson(Map<String, dynamic> json) {
    if (json["id"] != null) {
      id = json["id"];
    }

    if (json["gender"] != null) {
      gender = json["gender"];
    }
    if (json["description"] != null) {
      description = json["description"];
    }
    if (json["status"] != null) {
      status = json["status"];
    }
    if (json["createdAt"] != null) {
      createdAt = json["createdAt"];
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "gender": gender,
        "description": description,
        "status": status,
        "createdAt": createdAt,
      };
}
