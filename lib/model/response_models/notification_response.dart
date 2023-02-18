// To parse this JSON data, do
//
//     final notificationResponse = notificationResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

NotificationResponse notificationResponseFromJson(String str) =>
    NotificationResponse.fromJson(json.decode(str));

String notificationResponseToJson(NotificationResponse data) =>
    json.encode(data.toJson());

class NotificationResponse extends BaseResponse {
  NotificationResponse({this.note, message, baseStatus})
      : super(baseStatus: baseStatus, message: message);

  List<Note>? note;

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      NotificationResponse(
          note: List<Note>.from(json["note"].map((x) => Note.fromJson(x))),
          baseStatus: json["baseStatus"] ?? true,
          message: json["message"] ?? '');

  Map<String, dynamic> toJson() => {
        "note": List<dynamic>.from(note!.map((x) => x.toJson())),
        "message": message,
        "baseStatus": baseStatus,
      };
}

class Note {
  Note({
    this.id,
    this.message,
    this.recipientUserId,
    this.initiatorUserId,
    this.title,
    this.dateSent,
    this.readStatus,
  });

  int? id;
  String? message;
  int? recipientUserId;
  int? initiatorUserId;
  String? title;
  DateTime? dateSent;
  String? readStatus;

  Note.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    if (json["message"] != null) {
      message = json["message"];
    }
    if (json["recipientUserId"] != null) {
      recipientUserId = json["recipientUserId"];
    }
    if (json["initiatorUserId"] != null) {
      initiatorUserId = json["initiatorUserId"];
    }
    if (json["title"] != null) {
      title = json["title"];
    }
    if (json["dateSent"] != null) {
      dateSent = DateTime.parse(json["dateSent"]);
    }
    if (json["readStatus"] != null) {
      title = json["readStatus"];
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "recipientUserId": recipientUserId,
        "initiatorUserId": initiatorUserId,
        "title": title,
        "dateSent":
            "${dateSent!.year.toString().padLeft(4, '0')}-${dateSent!.month.toString().padLeft(2, '0')}-${dateSent!.day.toString().padLeft(2, '0')}",
        "readStatus": readStatus,
      };
}
