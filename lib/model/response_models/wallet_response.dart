// To parse this JSON data, do
//
//     final walletResponse = walletResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

WalletResponse walletResponseFromJson(String str) =>
    WalletResponse.fromJson(json.decode(str));

String walletResponseToJson(WalletResponse data) => json.encode(data.toJson());

class WalletResponse extends BaseResponse {
  WalletResponse({this.id, this.amount, message, baseStatus})
      : super(baseStatus: baseStatus, message: message);

  int? id;
  double? amount;

  factory WalletResponse.fromJson(Map<String, dynamic> json) => WalletResponse(
      id: json["id"],
      amount: json["amount"],
      message: json["message"] ?? "",
      baseStatus: json["baseStatus"] ?? true);

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "message": message,
        "baseStatus": baseStatus,
      };
}
