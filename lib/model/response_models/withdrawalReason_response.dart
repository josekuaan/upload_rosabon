// To parse this JSON data, do
//
//     final withdrawalReasonResponse = withdrawalReasonResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

WithdrawalReasonResponse withdrawalReasonResponseFromJson(String str) =>
    WithdrawalReasonResponse.fromJson(json.decode(str));

String withdrawalReasonResponseToJson(WithdrawalReasonResponse data) =>
    json.encode(data.toJson());

class WithdrawalReasonResponse extends BaseResponse {
  WithdrawalReasonResponse({this.withdrawalReason, message, baseStatus})
      : super(baseStatus: baseStatus, message: message);

  List<WithdrawalReason>? withdrawalReason;

  factory WithdrawalReasonResponse.fromJson(Map<String, dynamic> json) =>
      WithdrawalReasonResponse(
          withdrawalReason: List<WithdrawalReason>.from(json["withdrawalReason"]
              .map((x) => WithdrawalReason.fromJson(x))),
          message: json["message"] ?? "",
          baseStatus: json["baseStatus"] ?? true);

  Map<String, dynamic> toJson() => {
        "withdrawalReason":
            List<dynamic>.from(withdrawalReason!.map((x) => x.toJson())),
        "message": message,
        "baseStatus": baseStatus,
      };
}

class WithdrawalReason {
  WithdrawalReason({
    this.id,
    this.reason,
    this.status,
    this.createdDate,
  });

  int? id;
  String? reason;
  String? status;
  DateTime? createdDate;

  factory WithdrawalReason.fromJson(Map<String, dynamic> json) =>
      WithdrawalReason(
        id: json["id"],
        reason: json["reason"],
        status: json["status"],
        createdDate: DateTime.parse(json["createdDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reason": reason,
        "status": status,
        "createdDate":
            "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
      };
}
