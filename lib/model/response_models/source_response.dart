// To parse this JSON data, do
//
//     final sourceResponse = sourceResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

SourceResponse sourceResponseFromJson(String str) =>
    SourceResponse.fromJson(json.decode(str));

String sourceResponseToJson(SourceResponse data) => json.encode(data.toJson());

class SourceResponse extends BaseResponse {
  SourceResponse({this.sources, baseStatus, message})
      : super(baseStatus: baseStatus, message: message);

  List<Source>? sources;

  SourceResponse.fromJson(Map<String, dynamic> json) {
    sources = List<Source>.from(json["sources"].map((x) => Source.fromJson(x)));
    baseStatus = json["baseStatus"] ?? true;
    message = json["message"] ?? "";
    print(json["sources"]);
  }

  Map<String, dynamic> toJson() => {
        "sources": List<dynamic>.from(sources!.map((x) => x.toJson())),
        "message": message,
        "baseStatus": baseStatus,
      };
}

class Source {
  Source({
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

  Source.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    description = json["description"];
    status = json["status"];
    createdAt = json["createdAt"];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "status": status,
        "createdAt": createdAt,
      };
}
