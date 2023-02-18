// To parse this JSON data, do
//
//     final saveDocsResponse = saveDocsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

SaveDocsResponse saveDocsResponseFromJson(String str) =>
    SaveDocsResponse.fromJson(json.decode(str));

String saveDocsResponseToJson(SaveDocsResponse data) =>
    json.encode(data.toJson());

class SaveDocsResponse extends BaseResponse {
  SaveDocsResponse(
      {this.id,
      this.certificateOfIncoImage,
      this.cacImage,
      this.moaImage,
      this.contactPersonPhotographImage,
      this.idType,
      this.contactPersonIdImage,
      this.idNumber,
      this.utilityBillImage,
      message,
      baseStatus})
      : super(baseStatus: baseStatus, message: message);

  int? id;
  ImageFiles? certificateOfIncoImage;
  ImageFiles? cacImage;
  ImageFiles? moaImage;
  ImageFiles? contactPersonPhotographImage;
  IdType? idType;
  ImageFiles? contactPersonIdImage;
  String? idNumber;
  ImageFiles? utilityBillImage;

  factory SaveDocsResponse.fromJson(Map<String, dynamic> json) =>
      SaveDocsResponse(
          id: json["id"],
          certificateOfIncoImage:
              ImageFiles.fromJson(json["certificateOfIncoImage"]),
          cacImage: ImageFiles.fromJson(json["cacImage"]),
          moaImage: ImageFiles.fromJson(json["moaImage"]),
          contactPersonPhotographImage:
              ImageFiles.fromJson(json["contactPersonPhotographImage"]),
          idType:IdType.fromJson(
           json["idType"],),
          contactPersonIdImage:
              ImageFiles.fromJson(json["contactPersonIdImage"]),
          idNumber: json["idNumber"],
          utilityBillImage: ImageFiles.fromJson(json["utilityBillImage"]),
          message: json["message"] ?? "",
          baseStatus: json["baseStatus"] ?? true);

  Map<String, dynamic> toJson() => {
        "id": id,
        "certificateOfIncoImage": certificateOfIncoImage!.toJson(),
        "cacImage": cacImage!.toJson(),
        "moaImage": moaImage!.toJson(),
        "contactPersonPhotographImage": contactPersonPhotographImage!.toJson(),
        "idType": idType,
        "contactPersonIdImage": contactPersonIdImage!.toJson(),
        "idNumber": idNumber,
        "utilityBillImage": utilityBillImage!.toJson(),
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

class ImageFiles {
  ImageFiles({
    this.name,
    this.imageUrl,
    this.entityStatus,
  });

  String? name;
  String? imageUrl;
  String? entityStatus;

  factory ImageFiles.fromJson(Map<String, dynamic> json) => ImageFiles(
        name: json["name"] == null ? null : json["name"],
        imageUrl: json["imageUrl"],
        entityStatus: json["entityStatus"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "imageUrl": imageUrl,
        "entityStatus": entityStatus,
      };
}
