// To parse this JSON data, do
//
//     final withdrawPlanRequest = withdrawPlanRequestFromJson(jsonString);

import 'dart:convert';

WithdrawPlanRequest withdrawPlanRequestFromJson(String str) =>
    WithdrawPlanRequest.fromJson(json.decode(str));

String withdrawPlanRequestToJson(WithdrawPlanRequest data) =>
    json.encode(data.toJson());

class WithdrawPlanRequest {
  WithdrawPlanRequest({
    this.amount,
    this.completed,
    this.corporateUserWithdrawalMandate,
    this.extraDetails,
    this.paymentType,
    this.plan,
    this.planAction,
    this.penalCharge,
    this.planToReceive,
    this.withdrawTo,
    this.withdrawType,
  });

  int? amount;
  bool? completed;
  dynamic? corporateUserWithdrawalMandate;
  String? extraDetails;
  String? paymentType;
  int? plan;
  double? penalCharge;

  String? planAction;
  int? planToReceive;
  String? withdrawTo;
  String? withdrawType;

  factory WithdrawPlanRequest.fromJson(Map<String, dynamic> json) =>
      WithdrawPlanRequest(
        amount: json["amount"],
        penalCharge: json["penalCharge"],
        completed: json["completed"],
        corporateUserWithdrawalMandate: json["corporateUserWithdrawalMandate"],
        extraDetails: json["extraDetails"],
        paymentType: json["paymentType"],
        plan: json["plan"],
        planAction: json["planAction"],
        planToReceive: json["planToReceive"],
        withdrawTo: json["withdrawTo"],
        withdrawType: json["withdrawType"],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (amount != null) {
      data['amount'] = amount;
    }
    if (penalCharge != null) {
      data['penalCharge'] = penalCharge;
    }
    if (completed != null) {
      data['completed'] = completed;
    }
    if (corporateUserWithdrawalMandate != null) {
      data['corporateUserWithdrawalMandate'] = corporateUserWithdrawalMandate;
    }
    if (extraDetails != null) {
      data['extraDetails'] = extraDetails;
    }
    if (paymentType != null) {
      data['paymentType'] = paymentType;
    }
    if (plan != null) {
      data['plan'] = plan;
    }

    if (planAction != null) {
      data['planAction'] = planAction;
    }
    if (planToReceive != null) {
      data['planToReceive'] = planToReceive;
    }
    if (withdrawType != null) {
      data['withdrawType'] = withdrawType;
    }
    if (withdrawTo != null) {
      data['withdrawTo'] = withdrawTo;
    }

    return data;
  }
}
