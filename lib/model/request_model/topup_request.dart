// To parse this JSON data, do
//
//     final topUpRequest = topUpRequestFromJson(jsonString);

import 'dart:convert';

TopUpRequest topUpRequestFromJson(String str) =>
    TopUpRequest.fromJson(json.decode(str));

String topUpRequestToJson(TopUpRequest data) => json.encode(data.toJson());

class TopUpRequest {
  TopUpRequest({
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
  int? planToReceive;
  String? planAction;

  factory TopUpRequest.fromJson(Map<String, dynamic> json) => TopUpRequest(
        amount: json["amount"],
        completed: json["completed"],
        paymentType: json["paymentType"],
        plan: json["plan"],
        planToReceive: json["planToReceive"],
        planAction: json["planAction"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "completed": completed,
        "paymentType": paymentType,
        "plan": plan,
        "planToReceive": planToReceive,
        "planAction": planAction,
      };
}
