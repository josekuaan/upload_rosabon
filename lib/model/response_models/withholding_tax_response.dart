// To parse this JSON data, do
//
//     final withholdingTaxResponse = withholdingTaxResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

List<WithholdingTaxResponse> withholdingTaxResponseFromJson(String str) =>
    List<WithholdingTaxResponse>.from(
        json.decode(str).map((x) => WithholdingTaxResponse.fromJson(x)));

String withholdingTaxResponseToJson(List<WithholdingTaxResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WithholdingTaxResponse extends BaseResponse {
  WithholdingTaxResponse(
      {this.id, this.rate, this.createdAt, this.updatedAt, message, baseStatus})
      : super(baseStatus: baseStatus, message: message);

  int? id;
  double? rate;
  List<int>? createdAt;
  List<int>? updatedAt;

  WithholdingTaxResponse.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    rate = json["rate"];
    createdAt = List<int>.from(json["createdAt"].map((x) => x));
    updatedAt = List<int>.from(json["updatedAt"].map((x) => x));
    message = json["message"] ?? "";
    baseStatus = json["baseStatus"] ?? true;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "rate": rate,
        "createdAt": List<dynamic>.from(createdAt!.map((x) => x)),
        "updatedAt": List<dynamic>.from(updatedAt!.map((x) => x)),
        "message": message,
        "baseStatus": baseStatus,
      };
}
