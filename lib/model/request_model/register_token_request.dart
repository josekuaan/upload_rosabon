// To parse this JSON data, do
//
//     final registerTokenRequest = registerTokenRequestFromJson(jsonString);

import 'dart:convert';

RegisterTokenRequest registerTokenRequestFromJson(String str) =>
    RegisterTokenRequest.fromJson(json.decode(str));

String registerTokenRequestToJson(RegisterTokenRequest data) =>
    json.encode(data.toJson());

class RegisterTokenRequest {
  RegisterTokenRequest({
    this.device,
    this.token,
    this.userId,
  });

  String? device;
  String? token;
  int? userId;

  factory RegisterTokenRequest.fromJson(Map<String, dynamic> json) =>
      RegisterTokenRequest(
        device: json["device"],
        token: json["token"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "device": device,
        "token": token,
        "userId": userId,
      };
}
