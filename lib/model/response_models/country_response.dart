// To parse this JSON data, do
//
//     final countryResponse = countryResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

CountryResponse countryResponseFromJson(String str) =>
    CountryResponse.fromJson(json.decode(str));

String countryResponseToJson(CountryResponse data) =>
    json.encode(data.toJson());

class CountryResponse extends BaseResponse {
  CountryResponse({this.countries, message, baseStatus})
      : super(baseStatus: baseStatus, message: message);

  List<Country>? countries;

  CountryResponse.fromJson(Map<String, dynamic> json) {
  
    countries =
        List<Country>.from(json["countries"].map((x) => Country.fromJson(x)));
    message = json["message"] ?? "";
    baseStatus = json["baseStatus"] ?? true;
  }

  Map<String, dynamic> toJson() => {
        "countries": List<dynamic>.from(countries!.map((x) => x.toJson())),
        "message": message,
        "baseStatus": baseStatus,
      };
}

class Country {
  Country({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
