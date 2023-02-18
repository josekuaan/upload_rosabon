// To parse this JSON data, do
//
//     final changePasswordResponse = changePasswordResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

ChangePasswordResponse changePasswordResponseFromJson(String str) =>
    ChangePasswordResponse.fromJson(json.decode(str));

String changePasswordResponseToJson(ChangePasswordResponse data) =>
    json.encode(data.toJson());

class ChangePasswordResponse extends BaseResponse {
  ChangePasswordResponse({this.status, message, baseStatus})
      : super(baseStatus: baseStatus, message: message);

  int? status;
  // String? message;

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) =>
      ChangePasswordResponse(
          status: json["status"],
          message: json["message"] ?? "",
          baseStatus: json["baseStatus"] ?? true);

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "baseStatus": baseStatus,
      };
}
