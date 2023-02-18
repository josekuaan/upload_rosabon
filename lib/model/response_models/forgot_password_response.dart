// To parse this JSON data, do
//
//     final forgotPasswordResponse = forgotPasswordResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

ForgotPasswordResponse forgotPasswordResponseFromJson(String str) =>
    ForgotPasswordResponse.fromJson(json.decode(str));

String forgotPasswordResponseToJson(ForgotPasswordResponse data) =>
    json.encode(data.toJson());

class ForgotPasswordResponse extends BaseResponse {
  ForgotPasswordResponse({this.status, message, baseStatus})
      : super(baseStatus: baseStatus, message: message);

  int? status;
  // String? message;

  ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    baseStatus = json["baseStatus"] ?? true;
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "baseStatus": baseStatus,
      };
}
