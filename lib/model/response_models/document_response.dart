// To parse this JSON data, do
//
//     final documentResponse = documentResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

DocumentResponse documentResponseFromJson(String str) =>
    DocumentResponse.fromJson(json.decode(str));

String documentResponseToJson(DocumentResponse data) =>
    json.encode(data.toJson());

class DocumentResponse extends BaseResponse {
  int? id;
  ImagePhotograph? passportPhotographImage;
  IdType? idType;
  ImageDocument? idDocumentImage;
  String? idNumber;
  ImageUtilityBillI? utilityBillImage;
  DocumentResponse(
      {
      // this.docs,
      this.id,
      this.passportPhotographImage,
      this.idType,
      this.idDocumentImage,
      this.idNumber,
      this.utilityBillImage,
      message,
      baseStatus})
      : super(baseStatus: baseStatus, message: message);

  // List<Doc>? docs;

  factory DocumentResponse.fromJson(Map<String, dynamic> json) =>
      DocumentResponse(
        id: json["id"],
        passportPhotographImage: json["passportPhotographImage"] != null
            ? ImagePhotograph.fromJson(json["passportPhotographImage"])
            : null,

        // individualUser = json["individualUser"] != null
        //     ? IndividualUser.fromJson(json["individualUser"])
        //     : null;

        idType: json["idType"] != null ? IdType.fromJson(json["idType"]) : null,

        idDocumentImage: json["idDocumentImage"] != null
            ? ImageDocument.fromJson(json["idDocumentImage"])
            : null,

        // if (json["idNumber"] != null) {
        idNumber: json["idNumber"],
        // }
        utilityBillImage: json["utilityBillImage"] != null
            ? ImageUtilityBillI.fromJson(json["utilityBillImage"])
            : null,
        // print("=========================");
        // docs: List<Doc>.from(json["docs"].map((x) => Doc.fromJson(x))),
        // passportPhotographImage = List<ImagePhotograph>.from(json["passportPhotographImage"].map((x) => ImagePhotograph.fromJson(x)));
        message: json["message"] ?? "",
        baseStatus: json["baseStatus"] ?? true,
      );

  Map<String, dynamic> toJson() => {
        // "docs": List<dynamic>.from(docs!.map((x) => x.toJson())),
        "message": message,
        "baseStatus": baseStatus,
        "id": id,
        "passportPhotographImage": passportPhotographImage!.toJson(),
        "idType": idType,
        "idDocumentImage": idDocumentImage!.toJson(),
        "idNumber": idNumber,
        "utilityBillImage": utilityBillImage!.toJson(),
      };
}

class Doc {
  Doc({
    this.id,
    this.passportPhotographImage,
    this.idType,
    this.idDocumentImage,
    this.idNumber,
    this.utilityBillImage,
    // this.individualUser,
  });

  int? id;
  ImagePhotograph? passportPhotographImage;
  IdType? idType;
  ImageDocument? idDocumentImage;
  String? idNumber;
  ImageUtilityBillI? utilityBillImage;
  // IndividualUser? individualUser;

  Doc.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    passportPhotographImage = json["passportPhotographImage"] != null
        ? ImagePhotograph.fromJson(json["passportPhotographImage"])
        : null;

    // individualUser = json["individualUser"] != null
    //     ? IndividualUser.fromJson(json["individualUser"])
    //     : null;

    if (json["idType"] != null) {
      idType = IdType.fromJson(json["idType"]);
    }
    idDocumentImage = json["idDocumentImage"] != null
        ? ImageDocument.fromJson(json["idDocumentImage"])
        : null;

    if (json["idNumber"] != null) {
      idNumber = json["idNumber"];
    }
    utilityBillImage = json["utilityBillImage"] != null
        ? ImageUtilityBillI.fromJson(json["utilityBillImage"])
        : null;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "passportPhotographImage": passportPhotographImage!.toJson(),
        "idType": idType!.toJson(),
        "idDocumentImage": idDocumentImage!.toJson(),
        "idNumber": idNumber,
        "utilityBillImage": utilityBillImage!.toJson(),
        // "individualUser": individualUser!.toJson(),
      };
}

class IdType {
  IdType({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.createdAt,
  });

  int id;
  String name;
  String description;
  String status;
  String createdAt;

  factory IdType.fromJson(Map<String, dynamic> json) => IdType(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        status: json["status"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "status": status,
        "createdAt": createdAt,
      };
}

class ImagePhotograph {
  ImagePhotograph({
    this.name,
    this.imageUrl,
    this.entityStatus,
  });

  String? name;
  String? imageUrl;
  String? entityStatus;

  ImagePhotograph.fromJson(Map<String, dynamic> json) {
    if (json["name"] != null) {
      name = json["name"];
    }
    if (json["imageUrl"] != null) {
      imageUrl = json["imageUrl"];
    }
    if (json["entityStatus"] != null) {
      entityStatus = json["entityStatus"];
    }
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "imageUrl": imageUrl,
        "entityStatus": entityStatus,
      };
}

class ImageDocument {
  ImageDocument({
    this.name,
    this.imageUrl,
    this.entityStatus,
  });

  String? name;
  String? imageUrl;
  String? entityStatus;

  factory ImageDocument.fromJson(Map<String, dynamic> json) => ImageDocument(
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

class ImageUtilityBillI {
  ImageUtilityBillI({
    this.name,
    this.imageUrl,
    this.entityStatus,
  });

  String? name;
  String? imageUrl;
  String? entityStatus;

  factory ImageUtilityBillI.fromJson(Map<String, dynamic> json) =>
      ImageUtilityBillI(
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

class IndividualUser {
  IndividualUser({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.bvn,
    this.coutryOfResidence,
    this.state,
    this.lga,
    this.employmentDetail,
    this.nokDetail,
    this.businessType,
    this.bankAccountVerified,
  });

  int? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? dateOfBirth;
  String? gender;
  dynamic? address;
  String? bvn;
  CoutryOfResidence? coutryOfResidence;
  String? state;
  String? lga;
  dynamic? employmentDetail;
  dynamic? nokDetail;
  dynamic? businessType;
  bool? bankAccountVerified;

  IndividualUser.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    if (json["firstName"] != null) {
      firstName = json["firstName"];
    }
    if (json["middleName"] != null) {
      middleName = json["middleName"];
    }
    if (json["lastName"] != null) {
      lastName = json["lastName"];
    }
    if (json["dateOfBirth"] != null) {
      dateOfBirth = json["dateOfBirth"];
    }
    if (json["gender"] != null) {
      gender = json["gender"];
    }
    if (json["address"] != null) {
      address = json["address"];
    }
    if (json["bvn"] != null) {
      bvn = json["bvn"];
    }

    coutryOfResidence = json["coutryOfResidence"] != null
        ? CoutryOfResidence.fromJson(json["coutryOfResidence"])
        : null;
    if (json["state"] != null) {
      state = json["state"];
    }
    if (json["lga"] != null) {
      lga = json["lga"];
    }
    if (json["employmentDetail"] != null) {
      employmentDetail = json["employmentDetail"];
    }
    if (json["nokDetail"] != null) {
      nokDetail = json["nokDetail"];
    }

    if (json["businessType"] != null) {
      businessType = json["businessType"];
    }
    if (json["bankAccountVerified"] != null) {
      bankAccountVerified = json["bankAccountVerified"];
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "dateOfBirth": dateOfBirth,
        "gender": gender,
        "address": address,
        "bvn": bvn,
        "coutryOfResidence": coutryOfResidence!.toJson(),
        "state": state,
        "lga": lga,
        "employmentDetail": employmentDetail,
        "nokDetail": nokDetail,
        "businessType": businessType,
        "bankAccountVerified": bankAccountVerified,
      };
}

class CoutryOfResidence {
  CoutryOfResidence({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory CoutryOfResidence.fromJson(Map<String, dynamic> json) =>
      CoutryOfResidence(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
