// To parse this JSON data, do
//
//     final signupCompanyResponse = signupCompanyResponseFromJson(jsonString);

import 'dart:convert';

SignupCompanyResponse signupCompanyResponseFromJson(String str) =>
    SignupCompanyResponse.fromJson(json.decode(str));

String signupCompanyResponseToJson(SignupCompanyResponse data) =>
    json.encode(data.toJson());

class SignupCompanyResponse {
  SignupCompanyResponse({
    this.id,
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
    this.createdAt,
    this.individualUser,
    this.company,
    this.administrator,
  });

  int? id;
  String? phone;
  String? email;
  String? status;
  String? role;
  String? usage;
  String? source;
  String? sourceOthers;
  bool? isNewsLetters;
  bool? isKyc;
  bool? isAssited;
  String? referralLog;
  DateTime? createdAt;
  dynamic? individualUser;
  Company? company;
  dynamic? administrator;

  factory SignupCompanyResponse.fromJson(Map<String, dynamic> json) =>
      SignupCompanyResponse(
        id: json["id"],
        phone: json["phone"],
        email: json["email"],
        status: json["status"],
        role: json["role"],
        usage: json["usage"],
        source: json["source"],
        sourceOthers: json["sourceOthers"],
        isNewsLetters: json["isNewsLetters"],
        isKyc: json["isKyc"],
        isAssited: json["isAssited"],
        referralLog: json["referralLog"],
        createdAt: json["createdAt"],
        individualUser: json["individualUser"],
        company: Company.fromJson(json["company"]),
        administrator: json["administrator"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "email": email,
        "status": status,
        "role": role,
        "usage": usage,
        "source": source,
        "sourceOthers": sourceOthers,
        "isNewsLetters": isNewsLetters,
        "isKyc": isKyc,
        "isAssited": isAssited,
        "referralLog": referralLog,
        "createdAt": createdAt,
        "individualUser": individualUser,
        "company": company!.toJson(),
        "administrator": administrator,
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
