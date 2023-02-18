// To parse this JSON data, do
//
//     final bankRequest = bankRequestFromJson(jsonString);

import 'dart:convert';

BankRequest bankRequestFromJson(String str) =>
    BankRequest.fromJson(json.decode(str));

String bankRequestToJson(BankRequest data) => json.encode(data.toJson());

class BankRequest {
  BankRequest({
    this.bankCode,
    this.accountNumber,
    this.accountName,
    this.otp,
  });

  String? bankCode;
  String? accountNumber;
  String? accountName;
  String? otp;

  factory BankRequest.fromJson(Map<String, dynamic> json) => BankRequest(
        bankCode: json["bankCode"],
        accountNumber: json["accountNumber"],
        accountName: json["accountName"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "bankCode": bankCode,
        "accountNumber": accountNumber,
        "accountName": accountName,
        "otp": otp,
      };
}
