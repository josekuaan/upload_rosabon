// To parse this JSON data, do
//
//     final bvnRequest = bvnRequestFromJson(jsonString);

import 'dart:convert';

BvnRequest bvnRequestFromJson(String str) =>
    BvnRequest.fromJson(json.decode(str));

String bvnRequestToJson(BvnRequest data) => json.encode(data.toJson());

class BvnRequest {
  BvnRequest({
    this.firstName,
    this.id,
    this.isSubjectConsent,
    this.lastName,
    this.phoneNumber,
    this.dateOfBirth,
  });

  String? firstName;
  String? id;
  bool? isSubjectConsent;
  String? lastName;
  String? phoneNumber;
  String? dateOfBirth;

  factory BvnRequest.fromJson(Map<String, dynamic> json) => BvnRequest(
        firstName: json["firstName"],
        id: json["id"],
        isSubjectConsent: json["isSubjectConsent"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        dateOfBirth: json["dateOfBirth"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "id": id,
        "isSubjectConsent": isSubjectConsent,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "dateOfBirth": dateOfBirth,
      };
}
