// To parse this JSON data, do
//
//     final identityReponse = identityReponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

IdentityReponse identityReponseFromJson(String str) =>
    IdentityReponse.fromJson(json.decode(str));

String identityReponseToJson(IdentityReponse data) =>
    json.encode(data.toJson());

class IdentityReponse extends BaseResponse {
  IdentityReponse({this.ids, message, baseStatus})
      : super(baseStatus: baseStatus, message: message);

  List<Ids>? ids;

  factory IdentityReponse.fromJson(Map<String, dynamic> json) =>
      IdentityReponse(
          ids: List<Ids>.from(json["ids"].map((x) => Ids.fromJson(x))),
          message: json["message"] ?? "",
          baseStatus: json["baseStatus"] ?? true);

  Map<String, dynamic> toJson() => {
        "ids": List<dynamic>.from(ids!.map((x) => x.toJson())),
        "message": message,
        "baseStatus": baseStatus,
      };
}

class Ids {
  Ids({
    this.id,
    this.name,
    this.description,
    this.status,
    this.createdAt,
  });

  int? id;
  String? name;
  String? description;
  String? status;
  String? createdAt;

  factory Ids.fromJson(Map<String, dynamic> json) => Ids(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        status: json["status"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "status": status,
        "createdAt": createdAt,
      };
}
