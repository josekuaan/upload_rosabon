// To parse this JSON data, do
//
//     final transferRequest = transferRequestFromJson(jsonString);

import 'dart:convert';

TransferRequest transferRequestFromJson(String str) =>
    TransferRequest.fromJson(json.decode(str));

String transferRequestToJson(TransferRequest data) =>
    json.encode(data.toJson());

class TransferRequest {
  TransferRequest({
    this.amount,
    this.completed,
    this.paymentType,
    this.plan,
    this.planAction,
    this.planToReceive,
  });

  int? amount;
  bool? completed;
  String? paymentType;
  int? plan;
  String? planAction;
  int? planToReceive;

  factory TransferRequest.fromJson(Map<String, dynamic> json) =>
      TransferRequest(
        amount: json["amount"],
        completed: json["completed"],
        paymentType: json["paymentType"],
        plan: json["plan"],
        planAction: json["planAction"],
        planToReceive: json["planToReceive"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "completed": completed,
        "paymentType": paymentType,
        "plan": plan,
        "planAction": planAction,
        "planToReceive": planToReceive,
      };
}
