// To parse this JSON data, do
//
//     final verifyBankRequest = verifyBankRequestFromJson(jsonString);

import 'dart:convert';

VerifyAccountRequest verifyAccountRequestFromJson(String str) =>
    VerifyAccountRequest.fromJson(json.decode(str));

String verifyAccountRequestToJson(VerifyAccountRequest data) =>
    json.encode(data.toJson());

class VerifyAccountRequest {
  VerifyAccountRequest({
    this.accountNumber,
    this.bankCode,
    this.verifyBusinessBankAccount,
  });

  String? accountNumber;
  String? bankCode;
  bool? verifyBusinessBankAccount;

  factory VerifyAccountRequest.fromJson(Map<String, dynamic> json) =>
      VerifyAccountRequest(
        accountNumber: json["accountNumber"],
        bankCode: json["bankCode"],
        verifyBusinessBankAccount: json["verifyBusinessBankAccount"],
      );

  Map<String, dynamic> toJson() => {
        "accountNumber": accountNumber,
        "bankCode": bankCode,
        "verifyBusinessBankAccount": verifyBusinessBankAccount,
      };
}
