// To parse this JSON data, do
//
//     final moreDetailRequest = moreDetailRequestFromJson(jsonString);

import 'dart:convert';

MoreDetailRequest moreDetailRequestFromJson(String str) =>
    MoreDetailRequest.fromJson(json.decode(str));

String moreDetailRequestToJson(MoreDetailRequest data) =>
    json.encode(data.toJson());

class MoreDetailRequest {
  MoreDetailRequest({
    this.address,
    this.bvn,
    this.email,
    this.firstName,
    // this.id,
    this.idDocumentImage,
    this.idNumber,
    this.idTypeId,
    this.lastName,
    this.middleName,
    this.passportImage,
    this.phone,
  });

  String? address;
  String? bvn;
  String? email;
  String? firstName;
  // int? id;
  DocumentImage? idDocumentImage;
  String? idNumber;
  int? idTypeId;
  String? lastName;
  String? middleName;
  ProfileImage? passportImage;
  String? phone;

  factory MoreDetailRequest.fromJson(Map<String, dynamic> json) =>
      MoreDetailRequest(
        address: json["address"],
        bvn: json["bvn"],
        email: json["email"],
        firstName: json["firstName"],
        // id: json["id"],
        idDocumentImage: DocumentImage.fromJson(json["idDocumentImage"]),
        idNumber: json["idNumber"],
        idTypeId: json["idTypeId"],
        lastName: json["lastName"],
        middleName: json["middleName"],
        passportImage: ProfileImage.fromJson(json["passportImage"]),
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "bvn": bvn,
        "email": email,
        "firstName": firstName,
        // "id": id,
        "idDocumentImage": idDocumentImage!.toJson(),
        "idNumber": idNumber,
        "idTypeId": idTypeId,
        "lastName": lastName,
        "middleName": middleName,
        "passportImage": passportImage!.toJson(),
        "phone": phone,
      };
}

class DocumentImage {
  DocumentImage({
    this.encodedUpload,
    this.name,
  });

  String? encodedUpload;
  String? name;

  factory DocumentImage.fromJson(Map<String, dynamic> json) => DocumentImage(
        encodedUpload: json["encodedUpload"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "encodedUpload": encodedUpload,
        "name": name,
      };
}

class ProfileImage {
  ProfileImage({
    this.encodedUpload,
    this.name,
  });

  String? encodedUpload;
  String? name;

  factory ProfileImage.fromJson(Map<String, dynamic> json) => ProfileImage(
        encodedUpload: json["encodedUpload"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "encodedUpload": encodedUpload,
        "name": name,
      };
}
