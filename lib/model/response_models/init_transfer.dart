// To parse this JSON data, do
//
//     final initPlanTransfer = initPlanTransferFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

InitPlanTransfer initPlanTransferFromJson(String str) =>
    InitPlanTransfer.fromJson(json.decode(str));

String initPlanTransferToJson(InitPlanTransfer data) =>
    json.encode(data.toJson());

class InitPlanTransfer extends BaseResponse {
  InitPlanTransfer({this.planAction, message, baseStatus})
      : super(baseStatus: baseStatus, message: message);

  PlanAction? planAction;

  InitPlanTransfer.fromJson(Map<String, dynamic> json) {
    print(json["object"]);
    planAction = PlanAction.fromJson(json["object"]);
    baseStatus = json["baseStatus"] ?? true;
    message = json["message"] ?? '';
  }

  Map<String, dynamic> toJson() => {
        "planAction": planAction!.toJson(),
        "message": message,
        "baseStatus": baseStatus,
      };
}

class PlanAction {
  PlanAction({
    this.actionLogId,
    this.message,
  });

  int? actionLogId;
  String? message;

  factory PlanAction.fromJson(Map<String, dynamic> json) => PlanAction(
        actionLogId: json["actionLogId"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "actionLogId": actionLogId,
        "message": message,
      };
}
