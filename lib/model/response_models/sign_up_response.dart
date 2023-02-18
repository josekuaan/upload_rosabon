// To parse this JSON data, do
//
//     final signUpReponse = signUpReponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';
import 'package:rosabon/model/response_models/source_response.dart';

SignUpReponse signUpReponseFromJson(String str) =>
    SignUpReponse.fromJson(json.decode(str));

String signUpReponseToJson(SignUpReponse data) => json.encode(data.toJson());

class SignUpReponse extends BaseResponse {
  SignUpReponse(
      {this.id,
      this.phone,
      this.email,
      this.status,
      this.role,
      this.usage,
      this.source,
      this.sourceOthers,
      this.isNewsLetters,
      this.isKyc,
      this.isAssited,
      this.referralLog,
      this.referralCode,
      this.sourceNotInTheList,
      this.myReferralCode,
      this.createdAt,
      this.individualUser,
      this.company,
      this.administrator,
      baseStatus,
      message})
      : super(baseStatus: baseStatus, message: message);

  int? id;
  String? phone;
  String? email;
  String? status;
  String? role;
  String? usage;
  String? source;
  String? myReferralCode;
  // String? sourceOthers;
  bool? isNewsLetters;
  bool? isKyc;
  bool? isAssited;
  String? referralCode;
  String? referralLog;
  String? sourceNotInTheList;
  String? createdAt;
  IndividualUser? individualUser;
  Company? company;
  Source? sourceOthers;
  dynamic administrator;

  SignUpReponse.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    phone = json["phone"];
    email = json["email"];
    status = json["status"];
    role = json["role"];
    if (json["myReferralCode"] != null) {
      myReferralCode = json["myReferralCode"];
    }
     if (json["usage"] != null) {
      usage = json["usage"];
    }
    if (json["source"] != null) {
      source = json["source"];
    }
    if (json["sourceOthers"] != null) {
      sourceOthers = Source.fromJson(json["sourceOthers"]);
    }
    isNewsLetters = json["isNewsLetters"] ?? true;
    isKyc = json["isKyc"] ?? false;
    if (json["isAssited"] != null) {
      isAssited = json["isAssited"];
    }

    if (json["referralLog"] != null) {
      referralLog = json["referralLog"];
    }
    if (json["sourceNotInTheList"] != null) {
      sourceNotInTheList = json["sourceNotInTheList"];
    }
    if (json["referralCode"] != null) {
      referralCode = json["referralCode"];
    }

    if (json["createdAt"] != null) {
      createdAt = json["createdAt"];
    }
    individualUser = json["individualUser"] != null
        ? IndividualUser.fromJson(json["individualUser"])
        : null;
    company =
        json["company"] != null ? Company.fromJson(json["company"]) : null;
    if (json["administrator"] != null) {
      administrator = json["administrator"];
    }
    baseStatus = json["baseStatus"] ?? true;
    message = json["message"] ?? '';
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "email": email,
        "status": status,
        "role": role,
        "usage": usage,
        "myReferralCode": myReferralCode,
        "source": source,
        "sourceOthers": sourceOthers!.toJson(),
        "isNewsLetters": isNewsLetters,
        "isKyc": isKyc,
        "isAssited": isAssited,
        "referralLog": referralLog,
        "referralCode": referralCode,
        "sourceNotInTheList": sourceNotInTheList,
        "createdAt": createdAt,
        "individualUser": individualUser!.toJson(),
        "company": company!.toJson(),
        "administrator": administrator,
        "baseStatus": baseStatus,
        "message": message,
      };
}

class Company {
  Company({
    this.name,
    this.rcNumber,
    this.contactFirstName,
    this.contactMiddleName,
    this.contactLastName,
    this.dateOfInco,
    this.natureOfBusiness,
    this.companyType,
    this.companyAddress,
  });

  String? name;
  String? rcNumber;
  String? contactFirstName;
  String? contactMiddleName;
  String? contactLastName;
  DateTime? dateOfInco;
  String? natureOfBusiness;
  String? companyType;
  String? companyAddress;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        name: json["name"],
        rcNumber: json["rcNumber"],
        contactFirstName: json["contactFirstName"],
        contactMiddleName: json["contactMiddleName"],
        contactLastName: json["contactLastName"],
        dateOfInco: json["dateOfInco"],
        natureOfBusiness: json["natureOfBusiness"],
        companyType: json["companyType"],
        companyAddress: json["companyAddress"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "rcNumber": rcNumber,
        "contactFirstName": contactFirstName,
        "contactMiddleName": contactMiddleName,
        "contactLastName": contactLastName,
        "dateOfInco": dateOfInco,
        "natureOfBusiness": natureOfBusiness,
        "companyType": companyType,
        "companyAddress": companyAddress,
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
    this.coutryOfResidence,
    this.bvn,
  });

  int? id;
  String? firstName;
  String? middleName;
  String? lastName;
  DateTime? dateOfBirth;
  String? gender;
  String? address;
  String? coutryOfResidence;
  String? bvn;

  IndividualUser.fromJson(Map<String, dynamic> json) {
    print(json);
    id = json["id"];
    firstName = json["firstName"];
    middleName = json["middleName"] ?? "";
    lastName = json["lastName"] ?? "";
    if (json["dateOfBirth"] != null) {
      dateOfBirth = json["dateOfBirth"];
    }
    if (json["gender"] != null) {
      gender = json["gender"];
    }
    if (json["address"] != null) {
      address = json["address"];
    }
    if (json["coutryOfResidence"] != null) {
      coutryOfResidence = json["coutryOfResidence"];
    }
    if (json["bvn"] != null) {
      bvn = json["bvn"];
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
        "coutryOfResidence": coutryOfResidence,
      };
}
