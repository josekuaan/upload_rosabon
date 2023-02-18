// To parse this JSON data, do
//
//     final employmentRequest = employmentRequestFromJson(jsonString);

import 'dart:convert';

EmploymentRequest employmentRequestFromJson(String str) =>
    EmploymentRequest.fromJson(json.decode(str));

String employmentRequestToJson(EmploymentRequest data) =>
    json.encode(data.toJson());

class EmploymentRequest {
  EmploymentRequest({
    this.employerAddress,
    this.employerName,
    this.id,
    this.occupation,
  });

  EmployerAddress? employerAddress;
  String? employerName;
  int? id;
  String? occupation;

  factory EmploymentRequest.fromJson(Map<String, dynamic> json) =>
      EmploymentRequest(
        employerAddress: EmployerAddress.fromJson(json["employerAddress"]),
        employerName: json["employerName"],
        id: json["id"],
        occupation: json["occupation"],
      );

  Map<String, dynamic> toJson() => {
        "employerAddress": employerAddress!.toJson(),
        "employerName": employerName,
        "id": id,
        "occupation": occupation,
      };
}

class EmployerAddress {
  EmployerAddress({
    this.city,
    this.country,
    this.houseNoAddress,
    this.id,
    this.latitude,
    this.lga,
    this.longitude,
    this.postCode,
    this.state,
  });

  String? city;
  String? country;
  String? houseNoAddress;
  int? id;
  String? latitude;
  String? lga;
  String? longitude;
  String? postCode;
  String? state;

  factory EmployerAddress.fromJson(Map<String, dynamic> json) =>
      EmployerAddress(
        city: json["city"],
        country: json["country"],
        houseNoAddress: json["houseNoAddress"],
        id: json["id"],
        latitude: json["latitude"],
        lga: json["lga"],
        longitude: json["longitude"],
        postCode: json["postCode"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "country": country,
        "houseNoAddress": houseNoAddress,
        "id": id,
        "latitude": latitude,
        "lga": lga,
        "longitude": longitude,
        "postCode": postCode,
        "state": state,
      };
}
