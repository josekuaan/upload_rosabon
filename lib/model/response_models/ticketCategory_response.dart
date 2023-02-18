// To parse this JSON data, do
//
//     final ticketCategoryResponse = ticketCategoryResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

TicketCategoryResponse ticketCategoryResponseFromJson(String str) =>
    TicketCategoryResponse.fromJson(json.decode(str));

String ticketCategoryResponseToJson(TicketCategoryResponse data) =>
    json.encode(data.toJson());

class TicketCategoryResponse extends BaseResponse {
  TicketCategoryResponse({this.data, message, baseStatus})
      : super(baseStatus: baseStatus, message: message);

  List<TicketCategory>? data;

  factory TicketCategoryResponse.fromJson(Map<String, dynamic> json) =>
      TicketCategoryResponse(
          data: List<TicketCategory>.from(
              json["data"].map((x) => TicketCategory.fromJson(x))),
          message: json["message"] ?? "",
          baseStatus: json["baseStatus"] ?? true);

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "baseStatus": baseStatus,
      };
}

class TicketCategory {
  TicketCategory({
    this.id,
    this.name,
    this.status,
    this.description,
  });

  int? id;
  String? name;
  String? status;
  String? description;

  factory TicketCategory.fromJson(Map<String, dynamic> json) => TicketCategory(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "description": description,
      };
}
