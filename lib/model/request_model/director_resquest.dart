// To parse this JSON data, do
//
//     final directorRequest = directorRequestFromJson(jsonString);

import 'dart:convert';

List<DirectorRequest> directorRequestFromJson(String str) =>
    List<DirectorRequest>.from(
        json.decode(str).map((x) => DirectorRequest.fromJson(x)));

String directorRequestToJson(List<DirectorRequest> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DirectorRequest {
  DirectorRequest({
    this.address,
    this.bvn,
    this.email,
    this.firstName,
    this.id,
    this.idDocumentImage,
    this.idNumber,
    this.idType,
    this.lastName,
    this.middleName,
    this.passportImage,
    this.phone,
  });

  String? address;
  String? bvn;
  String? email;
  String? firstName;
  int? id;
  TImage? idDocumentImage;
  String? idNumber;
  String? idType;
  String? lastName;
  String? middleName;
  TImage? passportImage;
  String? phone;

  factory DirectorRequest.fromJson(Map<String, dynamic> json) =>
      DirectorRequest(
        address: json["address"],
        bvn: json["bvn"],
        email: json["email"],
        firstName: json["firstName"],
        id: json["id"],
        idDocumentImage: TImage.fromJson(json["idDocumentImage"]),
        idNumber: json["idNumber"],
        idType: json["idType"],
        lastName: json["lastName"],
        middleName: json["middleName"],
        passportImage: TImage.fromJson(json["passportImage"]),
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "bvn": bvn,
        "email": email,
        "firstName": firstName,
        "id": id,
        "idDocumentImage": idDocumentImage!.toJson(),
        "idNumber": idNumber,
        "idType": idType,
        "lastName": lastName,
        "middleName": middleName,
        "passportImage": passportImage!.toJson(),
        "phone": phone,
      };
}

class TImage {
  TImage({
    this.encodedUpload,
    this.name,
  });

  String? encodedUpload;
  String? name;

  factory TImage.fromJson(Map<String, dynamic> json) => TImage(
        encodedUpload: json["encodedUpload"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "encodedUpload": encodedUpload,
        "name": name,
      };
}
