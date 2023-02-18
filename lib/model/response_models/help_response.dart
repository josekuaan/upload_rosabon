// To parse this JSON data, do
//
//     final helpResponse = helpResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

HelpResponse helpResponseFromJson(String str) =>
    HelpResponse.fromJson(json.decode(str));

String helpResponseToJson(HelpResponse data) => json.encode(data.toJson());

class HelpResponse extends BaseResponse {
  HelpResponse({this.helpCenter, message, baseStatus})
      : super(baseStatus: baseStatus, message: message);

  List<HelpCenter>? helpCenter;

  factory HelpResponse.fromJson(Map<String, dynamic> json) => HelpResponse(
        helpCenter: List<HelpCenter>.from(
            json["body"].map((x) => HelpCenter.fromJson(x))),
        baseStatus: json["baseStatus"] ?? true,
        message: json["message"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "help": List<dynamic>.from(helpCenter!.map((x) => x.toJson())),
        "message": message,
        "baseStatus": baseStatus,
      };
}

class HelpCenter {
  HelpCenter({
    this.id,
    this.faqCategory,
    this.question,
    this.answer,
    this.status,
    this.dateAdded,
    this.dateUpdated,
  });

  int? id;
  // int? faqCategory;
  FaqCategory? faqCategory;
  String? question;
  String? answer;
  String? status;
  DateTime? dateAdded;
  DateTime? dateUpdated;

  factory HelpCenter.fromJson(Map<String, dynamic> json) => HelpCenter(
        id: json["id"],
        // faqCategory: json["faqCategory"],
        faqCategory: FaqCategory.fromJson(json["faqCategory"]),
        question: json["question"],
        answer: json["answer"],
        status: json["status"],
        // dateAdded: DateTime.parse(json["dateAdded"]),
        // dateUpdated: DateTime.parse(json["dateUpdated"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        // "faqCategory": faqCategory,
        "faqCategory": faqCategory!.toJson(),
        "question": question,
        "answer": answer,
        "status": status,
        "dateAdded":
            "${dateAdded!.year.toString().padLeft(4, '0')}-${dateAdded!.month.toString().padLeft(2, '0')}-${dateAdded!.day.toString().padLeft(2, '0')}",
        "dateUpdated":
            "${dateUpdated!.year.toString().padLeft(4, '0')}-${dateUpdated!.month.toString().padLeft(2, '0')}-${dateUpdated!.day.toString().padLeft(2, '0')}",
      };
}

class FaqCategory {
  FaqCategory({
    this.id,
    this.dateAdded,
    this.name,
    this.status,
    this.description,
  });

  int? id;
  DateTime? dateAdded;
  String? name;
  String? status;
  String? description;

  factory FaqCategory.fromJson(Map<String, dynamic> json) => FaqCategory(
        id: json["id"],
        // dateAdded: DateTime.parse(json["dateAdded"]),
        name: json["name"],
        status: json["status"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dateAdded":
            "${dateAdded!.year.toString().padLeft(4, '0')}-${dateAdded!.month.toString().padLeft(2, '0')}-${dateAdded!.day.toString().padLeft(2, '0')}",
        "name": name,
        "status": status,
        "description": description,
      };
}
