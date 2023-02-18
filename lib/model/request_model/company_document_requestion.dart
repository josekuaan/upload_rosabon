// To parse this JSON data, do
//
//     final companyDocumentRequest = companyDocumentRequestFromJson(jsonString);

import 'dart:convert';

CompanyDocumentRequest companyDocumentRequestFromJson(String str) =>
    CompanyDocumentRequest.fromJson(json.decode(str));

String companyDocumentRequestToJson(CompanyDocumentRequest data) =>
    json.encode(data.toJson());

class CompanyDocumentRequest {
  CompanyDocumentRequest({
    this.cacImage,
    this.certificateOfIncoImage,
    this.contactPersonIdNumber,
    this.contactPersonIdentityImage,
    this.contactPersonPhotographImage,
    this.idTypeId,
    this.moaImage,
    this.otp,
    this.utilityBillImage,
  });

  CacImage? cacImage;
  CertificateOfIncoImage? certificateOfIncoImage;
  String? contactPersonIdNumber;
  ContactPersonIdentityImage? contactPersonIdentityImage;
  ContactPersonPhotographImage? contactPersonPhotographImage;
  int? idTypeId;
  MoaImage? moaImage;
  String? otp;
  UtilityBillImage? utilityBillImage;

  factory CompanyDocumentRequest.fromJson(Map<String, dynamic> json) =>
      CompanyDocumentRequest(
        cacImage: CacImage.fromJson(json["cacImage"]),
        certificateOfIncoImage:
            CertificateOfIncoImage.fromJson(json["certificateOfIncoImage"]),
        contactPersonIdNumber: json["contactPersonIdNumber"],
        contactPersonIdentityImage: ContactPersonIdentityImage.fromJson(
            json["contactPersonIdentityImage"]),
        contactPersonPhotographImage: ContactPersonPhotographImage.fromJson(
            json["contactPersonPhotographImage"]),
        idTypeId: json["idTypeId"],
        moaImage: MoaImage.fromJson(json["moaImage"]),
        otp: json["otp"],
        utilityBillImage: UtilityBillImage.fromJson(json["utilityBillImage"]),
      );

  Map<String, dynamic> toJson() => {
        "cacImage": cacImage!.toJson(),
        "certificateOfIncoImage": certificateOfIncoImage!.toJson(),
        "contactPersonIdNumber": contactPersonIdNumber,
        "contactPersonIdentityImage": contactPersonIdentityImage!.toJson(),
        "contactPersonPhotographImage": contactPersonPhotographImage!.toJson(),
        "idTypeId": idTypeId,
        "moaImage": moaImage!.toJson(),
        "otp": otp,
        "utilityBillImage": utilityBillImage!.toJson(),
      };
}

class CacImage {
  CacImage({
    this.encodedUpload,
    this.name,
  });

  String? encodedUpload;
  String? name;

  factory CacImage.fromJson(Map<String, dynamic> json) => CacImage(
        encodedUpload: json["encodedUpload"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "encodedUpload": encodedUpload,
        "name": name,
      };
}

class CertificateOfIncoImage {
  CertificateOfIncoImage({
    this.encodedUpload,
    this.name,
  });

  String? encodedUpload;
  String? name;

  factory CertificateOfIncoImage.fromJson(Map<String, dynamic> json) =>
      CertificateOfIncoImage(
        encodedUpload: json["encodedUpload"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "encodedUpload": encodedUpload,
        "name": name,
      };
}

class ContactPersonIdentityImage {
  ContactPersonIdentityImage({
    this.encodedUpload,
    this.name,
  });

  String? encodedUpload;
  String? name;

  factory ContactPersonIdentityImage.fromJson(Map<String, dynamic> json) =>
      ContactPersonIdentityImage(
        encodedUpload: json["encodedUpload"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "encodedUpload": encodedUpload,
        "name": name,
      };
}

class ContactPersonPhotographImage {
  ContactPersonPhotographImage({
    this.encodedUpload,
    this.name,
  });

  String? encodedUpload;
  String? name;

  factory ContactPersonPhotographImage.fromJson(Map<String, dynamic> json) =>
      ContactPersonPhotographImage(
        encodedUpload: json["encodedUpload"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "encodedUpload": encodedUpload,
        "name": name,
      };
}

class MoaImage {
  MoaImage({
    this.encodedUpload,
    this.name,
  });

  String? encodedUpload;
  String? name;

  factory MoaImage.fromJson(Map<String, dynamic> json) => MoaImage(
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
