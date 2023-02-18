// To parse this JSON data, do
//
//     final resetPasswordRequest = resetPasswordRequestFromJson(jsonString);

import 'dart:convert';

ResetPasswordRequest resetPasswordRequestFromJson(String str) =>
    ResetPasswordRequest.fromJson(json.decode(str));

String resetPasswordRequestToJson(ResetPasswordRequest data) =>
    json.encode(data.toJson());

class ResetPasswordRequest {
  ResetPasswordRequest({
    this.email,
    this.newPassword,
    this.confirmPassword,
  });

  String? email;
  String? newPassword;
  String? confirmPassword;

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      ResetPasswordRequest(
        email: json["email"],
        newPassword: json["newPassword"],
        confirmPassword: json["confirmPassword"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword,
      };
}
