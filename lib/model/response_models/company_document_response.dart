// To parse this JSON data, do
//
//     final companyDocumentResponse = companyDocumentResponseFromJson(jsonString);

import 'dart:convert';

CompanyDocumentResponse companyDocumentResponseFromJson(String str) =>
    CompanyDocumentResponse.fromJson(json.decode(str));

String companyDocumentResponseToJson(CompanyDocumentResponse data) =>
    json.encode(data.toJson());

class CompanyDocumentResponse {
  CompanyDocumentResponse({
    this.id,
    this.certificateOfIncoImage,
    this.cacImage,
    this.moaImage,
    this.contactPersonPhotographImage,
    this.idType,
    this.contactPersonIdImage,
    this.idNumber,
  });

  int? id;
  CertificateOfIncoImage? certificateOfIncoImage;
  CacImage? cacImage;
  MoaImage? moaImage;
  ContactPersonPhotographImage? contactPersonPhotographImage;
  String? idType;
  ContactPersonIdImage? contactPersonIdImage;
  String? idNumber;

  factory CompanyDocumentResponse.fromJson(Map<String, dynamic> json) =>
      CompanyDocumentResponse(
        id: json["id"],
        certificateOfIncoImage:
            CertificateOfIncoImage.fromJson(json["certificateOfIncoImage"]),
        cacImage: CacImage.fromJson(json["cacImage"]),
        moaImage: MoaImage.fromJson(json["moaImage"]),
        contactPersonPhotographImage: ContactPersonPhotographImage.fromJson(
            json["contactPersonPhotographImage"]),
        idType: json["idType"],
        contactPersonIdImage:
            ContactPersonIdImage.fromJson(json["contactPersonIdImage"]),
        idNumber: json["idNumber"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "certificateOfIncoImage": certificateOfIncoImage!.toJson(),
        "cacImage": cacImage!.toJson(),
        "moaImage": moaImage!.toJson(),
        "contactPersonPhotographImage": contactPersonPhotographImage!.toJson(),
        "idType": idType,
        "contactPersonIdImage": contactPersonIdImage!.toJson(),
        "idNumber": idNumber,
      };
}

class MoaImage {
  MoaImage({
    this.name,
    this.imageUrl,
    this.entityStatus,
  });

  dynamic? name;
  String? imageUrl;
  String? entityStatus;

  MoaImage.fromJson(Map<String, dynamic> json) {
    if (json["name"] != null) {
      name = json["name"];
    }
    if (json["imageUrl"] != null) {
      imageUrl = json["imageUrl"];
    }
    if (json["entityStatus"] != null) {
      imageUrl = json["entityStatus"];
    }
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "imageUrl": imageUrl,
        "entityStatus": entityStatus,
      };
}

class CacImage {
  CacImage({
    this.name,
    this.imageUrl,
    this.entityStatus,
  });

  dynamic? name;
  String? imageUrl;
  String? entityStatus;

  CacImage.fromJson(Map<String, dynamic> json) {
    if (json["name"] != null) {
      name = json["name"];
    }
    if (json["imageUrl"] != null) {
      imageUrl = json["imageUrl"];
    }
    if (json["entityStatus"] != null) {
      imageUrl = json["entityStatus"];
    }
  }
  Map<String, dynamic> toJson() => {
        "name": name,
        "imageUrl": imageUrl,
        "entityStatus": entityStatus,
      };
}

class ContactPersonIdImage {
  ContactPersonIdImage({
    this.name,
    this.imageUrl,
    this.entityStatus,
  });

  dynamic? name;
  String? imageUrl;
  String? entityStatus;

  ContactPersonIdImage.fromJson(Map<String, dynamic> json) {
    if (json["name"] != null) {
      name = json["name"];
    }
    if (json["imageUrl"] != null) {
      imageUrl = json["imageUrl"];
    }
    if (json["entityStatus"] != null) {
      imageUrl = json["entityStatus"];
    }
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "imageUrl": imageUrl,
        "entityStatus": entityStatus,
      };
}

class CertificateOfIncoImage {
  CertificateOfIncoImage({
    this.name,
    this.imageUrl,
    this.entityStatus,
  });

  dynamic? name;
  String? imageUrl;
  String? entityStatus;

  CertificateOfIncoImage.fromJson(Map<String, dynamic> json) {
    if (json["name"] != null) {
      name = json["name"];
    }
    if (json["imageUrl"] != null) {
      imageUrl = json["imageUrl"];
    }
    if (json["entityStatus"] != null) {
      imageUrl = json["entityStatus"];
    }
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "imageUrl": imageUrl,
        "entityStatus": entityStatus,
      };
}

class ContactPersonPhotographImage {
  ContactPersonPhotographImage({
    this.name,
    this.imageUrl,
    this.entityStatus,
  });

  dynamic? name;
  String? imageUrl;
  String? entityStatus;

  ContactPersonPhotographImage.fromJson(Map<String, dynamic> json) {
    if (json["name"] != null) {
      name = json["name"];
    }
    if (json["imageUrl"] != null) {
      imageUrl = json["imageUrl"];
    }
    if (json["entityStatus"] != null) {
      imageUrl = json["entityStatus"];
    }
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "imageUrl": imageUrl,
        "entityStatus": entityStatus,
      };
}
