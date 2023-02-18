// To parse this JSON data, do
//
//     final directorResponse = directorResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

DirectorResponse directorResponseFromJson(String str) =>
    DirectorResponse.fromJson(json.decode(str));

String directorResponseToJson(DirectorResponse data) =>
    json.encode(data.toJson());

class DirectorResponse extends BaseResponse {
  DirectorResponse({this.data, message, baseStatus})
      : super(baseStatus: baseStatus, message: message);

  List<DirectorDetails>? data;

  factory DirectorResponse.fromJson(Map<String, dynamic> json) =>
      DirectorResponse(
        data: List<DirectorDetails>.from(
            json["data"].map((x) => DirectorDetails.fromJson(x))),
        message: json["message"] ?? "",
        baseStatus: json["baseStatus"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "baseStatus": baseStatus,
      };
}

class IdType {
  int? id;
  String? name;
  String? description;
  String? createdDate;
  String? status;
  IdType({
    this.createdDate,
    this.description,
    this.id,
    this.name,
    this.status,
  });
  factory IdType.fromJson(Map<String, dynamic> json) => IdType(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        description: json["description"],
        createdDate: json["createdAt"],
      );
}

class DirectorDetails {
  DirectorDetails({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.address,
    this.email,
    this.phone,
    this.bvn,
    this.idType,
    this.idDocumentImage,
    this.idNumber,
    this.passportImage,
  });

  int? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? address;
  String? email;
  String? phone;
  String? bvn;
  IdType? idType;
  IdDocumentImage? idDocumentImage;
  String? idNumber;
  PassportImage? passportImage;

  factory DirectorDetails.fromJson(Map<String, dynamic> json) =>
      DirectorDetails(
        id: json["id"],
        firstName: json["firstName"],
        middleName: json["middleName"],
        lastName: json["lastName"],
        address: json["address"],
        email: json["email"],
        phone: json["phone"],
        bvn: json["bvn"],

        idNumber: json["idNumber"],
        passportImage: PassportImage.fromJson(json["passportImage"]),

        idDocumentImage:
            // json["IdDocumentImage"] !=null?

            IdDocumentImage.fromJson(json["idDocumentImage"]),
        idType:   IdType.fromJson(  json["idType"],)

        //  :null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "address": address,
        "email": email,
        "phone": phone,
        "bvn": bvn,
        "idType": idType,
        "idDocumentImage": idDocumentImage!.toJson(),
        "idNumber": idNumber,
        "passportImage": passportImage!.toJson(),
      };
}

class IdDocumentImage {
  IdDocumentImage({
    this.name,
    this.imageUrl,
    this.entityStatus,
  });

  String? name;
  String? imageUrl;
  String? entityStatus;

  factory IdDocumentImage.fromJson(Map<String, dynamic> json) =>
      IdDocumentImage(
        name: json["name"],
        imageUrl: json["imageUrl"],
        entityStatus: json["entityStatus"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "imageUrl": imageUrl,
        "entityStatus": entityStatus,
      };
}

class PassportImage {
  PassportImage({
    this.name,
    this.imageUrl,
    this.entityStatus,
  });

  String? name;
  String? imageUrl;
  String? entityStatus;

  factory PassportImage.fromJson(Map<String, dynamic> json) => PassportImage(
        name: json["name"],
        imageUrl: json["imageUrl"],
        entityStatus: json["entityStatus"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "imageUrl": imageUrl,
        "entityStatus": entityStatus,
      };
}
