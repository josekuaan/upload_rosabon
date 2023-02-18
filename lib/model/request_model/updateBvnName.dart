// To parse this JSON data, do
//
//     final updateBvnNameRequest = updateBvnNameRequestFromJson(jsonString);

import 'dart:convert';

UpdateBvnNameRequest updateBvnNameRequestFromJson(String str) =>
    UpdateBvnNameRequest.fromJson(json.decode(str));

String updateBvnNameRequestToJson(UpdateBvnNameRequest data) =>
    json.encode(data.toJson());

class UpdateBvnNameRequest {
  UpdateBvnNameRequest({this.firstName, this.lastName});

  String? firstName;
  String? lastName;

  factory UpdateBvnNameRequest.fromJson(Map<String, dynamic> json) =>
      UpdateBvnNameRequest(
          firstName: json["firstName"], lastName: json["lastName"]);

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
      };
}
