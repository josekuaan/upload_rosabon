// To parse this JSON data, do
//
//     final documentRequest = documentRequestFromJson(jsonString);

import 'dart:convert';

DocumentRequest documentRequestFromJson(String str) =>
    DocumentRequest.fromJson(json.decode(str));

String documentRequestToJson(DocumentRequest data) =>
    json.encode(data.toJson());

class DocumentRequest {
  DocumentRequest({
    this.idDocumentImage,
    this.idNumber,
    this.idTypeId,
    this.otp,
    this.passportPhotographImage,
    this.utilityBillImage,
  });

  DocumentImage? idDocumentImage;
  String? idNumber;
  int? idTypeId;
  String? otp;
  ProfileImage? passportPhotographImage;
  UtilityBillImage? utilityBillImage;

  factory DocumentRequest.fromJson(Map<String, dynamic> json) =>
      DocumentRequest(
        idDocumentImage: DocumentImage.fromJson(json["idDocumentImage"]),
        idNumber: json["idNumber"],
        idTypeId: json["idTypeId"],
        otp: json["otp"],
        passportPhotographImage:
            ProfileImage.fromJson(json["passportPhotographImage"]),
        utilityBillImage: UtilityBillImage.fromJson(json["utilityBillImage"]),
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["idDocumentImage"] =
        idDocumentImage != null ? idDocumentImage!.toJson() : null;
    data["idNumber"] = idNumber ?? null;
    data["idTypeId"] = idTypeId ?? null;
    data["otp"] = otp;
    data["passportPhotographImage"] = passportPhotographImage != null
        ? passportPhotographImage!.toJson()
        : null;
    data["utilityBillImage"] =
        utilityBillImage != null ? utilityBillImage!.toJson() : null;
    return data;
  }
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

class UtilityBillImage {
  UtilityBillImage({
    this.encodedUpload,
    this.name,
  });

  String? encodedUpload;
  String? name;

  factory UtilityBillImage.fromJson(Map<String, dynamic> json) =>
      UtilityBillImage(
        encodedUpload: json["encodedUpload"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "encodedUpload": encodedUpload,
        "name": name,
      };
}
