// To parse this JSON data, do
//
//     final stateResponse = stateResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

StateResponse stateResponseFromJson(String str) =>
    StateResponse.fromJson(json.decode(str));

String stateResponseToJson(StateResponse data) => json.encode(data.toJson());

class StateResponse extends BaseResponse {
  StateResponse({this.state, message, baseStatus})
      : super(baseStatus: baseStatus, message: message);

  List<StateRes>? state;

  StateResponse.fromJson(Map<String, dynamic> json) {
    state = List<StateRes>.from(json["state"].map((x) => StateRes.fromJson(x)));
    message = json["message"] ?? "";
    baseStatus = json["baseStatus"] ?? true;
  }

  Map<String, dynamic> toJson() => {
        "state": List<StateRes>.from(state!.map((x) => x.toJson())),
        "message": message,
        "baseStatus": baseStatus,
      };
}

class StateRes {
  StateRes({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory StateRes.fromJson(Map<String, dynamic> json) => StateRes(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
