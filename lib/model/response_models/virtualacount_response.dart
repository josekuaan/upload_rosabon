// To parse this JSON data, do
//
//     final virtualAccountResponse = virtualAccountResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

VirtualAccountResponse virtualAccountResponseFromJson(String str) =>
    VirtualAccountResponse.fromJson(json.decode(str));

String virtualAccountResponseToJson(VirtualAccountResponse data) =>
    json.encode(data.toJson());

class VirtualAccountResponse extends BaseResponse {
  VirtualAccountResponse(
      {this.id,
      this.accountInitiationTransactionRef,
      this.accountName,
      this.accountNumber,
      this.bankName,
      this.plan,
      this.accountType,
      message,
      baseStatus})
      : super(baseStatus: baseStatus, message: message);

  int? id;
  dynamic? accountInitiationTransactionRef;
  String? accountName;
  String? accountNumber;
  String? bankName;
  dynamic? plan;
  String? accountType;

  VirtualAccountResponse.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    if (json["accountInitiationTransactionRef"] != null) {
      accountInitiationTransactionRef = json["accountInitiationTransactionRef"];
    }
    if (json["accountName"] != null) {
      accountName = json["accountName"];
    }
    if (json["accountNumber"] != null) {
      accountNumber = json["accountNumber"];
    }
    if (json["accountType"] != null) {
      accountType = json["accountType"];
    }
    if (json["bankName"] != null) {
      bankName = json["bankName"];
    }
    if (json["plan"] != null) {
      plan = json["plan"];
    }
    message = json["message"] ?? "";
    baseStatus = json["baseStatus"] ?? true;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "accountInitiationTransactionRef": accountInitiationTransactionRef,
        "accountName": accountName,
        "accountNumber": accountNumber,
        "plan": plan,
        "accountType": accountType,
        "bankName": bankName,
        "message": message,
        "baseStatus": baseStatus,
      };
}
