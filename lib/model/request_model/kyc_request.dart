// To parse this JSON data, do
//
//     final kycRequest = kycRequestFromJson(jsonString);

import 'dart:convert';

KycRequest kycRequestFromJson(String str) =>
    KycRequest.fromJson(json.decode(str));

String kycRequestToJson(KycRequest data) => json.encode(data.toJson());

class KycRequest {
  KycRequest({
    this.company,
    this.individualUser,
    this.isAssited,
    this.isKyc,
    this.isNewsLetters,
    this.phone,
    this.role,
    this.source,
    this.sourceOthers,
    this.status,
    this.usage,
  });

  Company? company;
  IndividualUser? individualUser;
  bool? isAssited;
  bool? isKyc;
  bool? isNewsLetters;
  String? phone;
  String? role;
  String? source;
  String? sourceOthers;
  String? status;
  String? usage;

  factory KycRequest.fromJson(Map<String, dynamic> json) => KycRequest(
        company:
            json["company"] == null ? null : Company.fromJson(json["company"]),
        individualUser: json["individualUser"] == null
            ? null
            : IndividualUser.fromJson(json["individualUser"]),
        isAssited: json["isAssited"],
        isKyc: json["isKyc"],
        isNewsLetters: json["isNewsLetters"],
        phone: json["phone"],
        role: json["role"],
        source: json["source"],
        sourceOthers: json["sourceOthers"],
        status: json["status"],
        usage: json["usage"],
      );

  Map<String, dynamic> toJson() => {
        "company": company == null ? null : company!.toJson(),
        "individualUser":
            individualUser == null ? null : individualUser!.toJson(),
        "isAssited": isAssited,
        "isKyc": isKyc,
        "isNewsLetters": isNewsLetters,
        "phone": phone,
        "role": role,
        "source": source,
        "sourceOthers": sourceOthers,
        "status": status,
        "usage": usage,
      };
}

class Company {
  Company({
    this.companyAddress,
    this.businessType,
    this.contactFirstName,
    this.contactLastName,
    this.contactMiddleName,
    this.dateOfInco,
    this.name,
    this.natureOfBusiness,
    this.rcNumber,
  });

  String? companyAddress;
  String? businessType;
  String? contactFirstName;
  String? contactLastName;
  String? contactMiddleName;
  String? dateOfInco;
  String? name;
  String? natureOfBusiness;
  String? rcNumber;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        companyAddress: json["companyAddress"],
        businessType: json["businessType"],
        contactFirstName: json["contactFirstName"],
        contactLastName: json["contactLastName"],
        contactMiddleName: json["contactMiddleName"],
        dateOfInco: json["dateOfInco"],
        name: json["name"],
        natureOfBusiness: json["natureOfBusiness"],
        rcNumber: json["rcNumber"],
      );

  Map<String, dynamic> toJson() => {
        "companyAddress": companyAddress,
        "businessType": businessType,
        "contactFirstName": contactFirstName,
        "contactLastName": contactLastName,
        "contactMiddleName": contactMiddleName,
        "dateOfInco": dateOfInco,
        "name": name,
        "natureOfBusiness": natureOfBusiness,
        "rcNumber": rcNumber,
      };
}

class IndividualUser {
  IndividualUser({
    this.bvn,
    this.contactAddress,
    this.coutryOfResidence,
    this.dateOfBirth,
    this.firstName,
    this.genderId,
    this.lastName,
    this.middleName,
  });

  String? bvn;
  Address? contactAddress;
  CoutryOfResidence? coutryOfResidence;
  String? dateOfBirth;
  String? firstName;
  int? genderId;
  String? lastName;
  String? middleName;

  factory IndividualUser.fromJson(Map<String, dynamic> json) => IndividualUser(
        bvn: json["bvn"],
        contactAddress: Address.fromJson(json["contactAddress"]),
        coutryOfResidence:
            CoutryOfResidence.fromJson(json["coutryOfResidence"]),
        dateOfBirth: json["dateOfBirth"],
        firstName: json["firstName"],
        genderId: json["genderId"],
        lastName: json["lastName"],
        middleName: json["middleName"],
      );

  Map<String, dynamic> toJson() => {
        "bvn": bvn,
        "contactAddress": contactAddress!.toJson(),
        "coutryOfResidence": coutryOfResidence!.toJson(),
        "dateOfBirth": dateOfBirth,
        "firstName": firstName,
        "genderId": genderId,
        "lastName": lastName,
        "middleName": middleName,
      };
}

class Address {
  Address({
    this.city,
    this.country,
    this.houseNoAddress,
    this.id,
    this.postCode,
    this.state,
  });

  String? city;
  String? country;
  String? houseNoAddress;
  int? id;
  String? postCode;
  String? state;

  Address.fromJson(Map<String, dynamic> json) {
    if (json["city"] != null) {
      city = json["city"];
    }
    if (json["country"] != null) {
      country = json["country"];
    }
    if (json["houseNoAddress"] != null) {
      houseNoAddress = json["houseNoAddress"];
    }
    if (json["id"] != null) {
      id = json["id"];
    }
    if (json["postCode"] != null) {
      postCode = json["postCode"];
    }
    if (json["state"] != null) {
      state = json["state"];
    }
  }

  Map<String, dynamic> toJson() => {
        "city": city,
        "country": country,
        "houseNoAddress": houseNoAddress,
        "id": id,
        "postCode": postCode,
        "state": state,
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
