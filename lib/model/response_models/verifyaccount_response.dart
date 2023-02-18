// To parse this JSON data, do
//
//     final verifyAccountResponse = verifyAccountResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

VerifyAccountResponse verifyAccountResponseFromJson(String str) =>
    VerifyAccountResponse.fromJson(json.decode(str));

String verifyAccountResponseToJson(VerifyAccountResponse data) =>
    json.encode(data.toJson());

class VerifyAccountResponse extends BaseResponse {
  VerifyAccountResponse({this.account, baseStatus, message})
      : super(baseStatus: baseStatus, message: message);

  Account? account;

  factory VerifyAccountResponse.fromJson(Map<String, dynamic> json) =>
      VerifyAccountResponse(
          account: Account.fromJson(json["account"]),
          baseStatus: json["baseStatus"] ?? true,
          message: json["message"] ?? '');

  Map<String, dynamic> toJson() => {
        "account": account!.toJson(),
        "baseStatus": baseStatus,
        "message": message,
      };
}

class Account {
  Account({
    this.accountNumber,
    this.accountName,
    this.bankId,
  });

  String? accountNumber;
  String? accountName;
  String? bankId;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        accountNumber: json["account_number"],
        accountName: json["account_name"],
        bankId: json["bank_id"],
      );

  Map<String, dynamic> toJson() => {
        "account_number": accountNumber,
        "account_name": accountName,
        "bank_id": bankId,
      };
}
