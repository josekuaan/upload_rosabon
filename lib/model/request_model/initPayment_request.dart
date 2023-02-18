// To parse this JSON data, do
//
//     final initPaymentRequest = initPaymentRequestFromJson(jsonString);

import 'dart:convert';

InitPaymentRequest initPaymentRequestFromJson(String str) =>
    InitPaymentRequest.fromJson(json.decode(str));

String initPaymentRequestToJson(InitPaymentRequest data) =>
    json.encode(data.toJson());

class InitPaymentRequest {
  InitPaymentRequest({
    this.amount,
    this.email,
  });

  String? amount;
  String? email;

  factory InitPaymentRequest.fromJson(Map<String, dynamic> json) =>
      InitPaymentRequest(
        amount: json["amount"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "email": email,
      };
}
