// To parse this JSON data, do
//
//     final planHistoryResponse = planHistoryResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

PlanHistoryResponse planHistoryResponseFromJson(String str) =>
    PlanHistoryResponse.fromJson(json.decode(str));

String planHistoryResponseToJson(PlanHistoryResponse data) =>
    json.encode(data.toJson());

class PlanHistoryResponse extends BaseResponse {
  PlanHistoryResponse({this.history, message, baseStatus})
      : super(baseStatus: baseStatus, message: message);

  List<History>? history;

  factory PlanHistoryResponse.fromJson(Map<String, dynamic> json) =>
      PlanHistoryResponse(
          history: List<History>.from(
              json["history"].map((x) => History.fromJson(x))),
          baseStatus: json["baseStatus"] ?? true,
          message: json["message"] ?? '');

  Map<String, dynamic> toJson() => {
        "history": List<dynamic>.from(history!.map((x) => x.toJson())),
        "message": message,
        "baseStatus": baseStatus,
      };
}

class History {
  History({
    this.id,
    this.transactionId,
    this.dateOfTransaction,
    this.description,
    this.type,
    this.balance,
    this.amount,
  });

  int? id;
  String? transactionId;
  DateTime? dateOfTransaction;
  String? description;
  String? type;
  double? balance;
  double? amount;

  History.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    transactionId=
    json["transactionId"];
    if (json["dateOfTransaction"] != null) {
      dateOfTransaction = DateTime.parse(json["dateOfTransaction"]);
    }

    // if (json["virtualAccountName"] != null) {
    //   virtualAccountName = json["virtualAccountName"];
    // }
    description=
    json["description"];
    type=
    json["type"];
    balance=
    json["balance"];
    amount=
    json["amount"];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "transactionId": transactionId,
        "dateOfTransaction":
            "${dateOfTransaction!.year.toString().padLeft(4, '0')}-${dateOfTransaction!.month.toString().padLeft(2, '0')}-${dateOfTransaction!.day.toString().padLeft(2, '0')}",
        "description": description,
        "type": type,
        "balance": balance,
        "amount": amount,
      };
}
