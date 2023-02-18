// To parse this JSON data, do
//
//     final signUpRequest = signUpRequestFromJson(jsonString);

import 'dart:convert';

SignUpRequest signUpRequestFromJson(String str) =>
    SignUpRequest.fromJson(json.decode(str));

String signUpRequestToJson(SignUpRequest data) => json.encode(data.toJson());

class SignUpRequest {
  SignUpRequest({
    this.company,
    this.email,
    this.individualUser,
    this.isAssited,
    this.isNewsLetters,
    this.password,
    this.phone,
    this.refferedBy,
    this.role,
    this.source,
    this.sourceOthersId,
    this.sourceOthers,
    this.sourceNotInTheList,
    this.usage,
  });

  Company? company;
  String? email;
  IndividualUser? individualUser;
  bool? isAssited;
  bool? isNewsLetters;
  String? password;
  String? phone;
  String? refferedBy;
  String? role;
  String? source;
  int? sourceOthersId;
  String? sourceNotInTheList;
  String? sourceOthers;
  String? usage;

  factory SignUpRequest.fromJson(Map<String, dynamic> json) => SignUpRequest(
        company: Company.fromJson(json["company"]),
        email: json["email"],
        individualUser: IndividualUser.fromJson(json["individualUser"]),
        isAssited: json["isAssited"],
        isNewsLetters: json["isNewsLetters"],
        password: json["password"],
        phone: json["phone"],
        refferedBy: json["refferedBy"],
        role: json["role"],
        source: json["source"],
        sourceOthersId: json["sourceOthersId"],
        sourceNotInTheList: json["sourceNotInTheList"],
        sourceOthers: json["sourceOthers"],
        usage: json["usage"],
      );

  Map<String, dynamic> toJson() => {
        "company": company == null ? null : company!.toJson(),
        "email": email,
        "individualUser":
            individualUser == null ? null : individualUser!.toJson(),
        "isAssited": isAssited,
        "isNewsLetters": isNewsLetters,
        "password": password,
        "phone": phone,
        "refferedBy": refferedBy,
        "role": role,
        "source": source,
        "sourceOthersId": sourceOthersId,
        "sourceNotInTheList": sourceNotInTheList,
        "sourceOthers": sourceOthers,
        "usage": usage,
      };
}

class Company {
  Company({
    this.contactFirstName,
    this.contactLastName,
    this.contactMiddleName,
    this.name,
  });

  String? contactFirstName;
  String? contactLastName;
  String? contactMiddleName;
  String? name;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        contactFirstName: json["contactFirstName"],
        contactLastName: json["contactLastName"],
        contactMiddleName: json["contactMiddleName"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "contactFirstName": contactFirstName,
        "contactLastName": contactLastName,
        "contactMiddleName": contactMiddleName,
        "name": name,
      };
}

class IndividualUser {
  IndividualUser({
    this.firstName,
    this.lastName,
    this.middleName,
  });

  String? firstName;
  String? lastName;
  String? middleName;

  factory IndividualUser.fromJson(Map<String, dynamic> json) => IndividualUser(
        firstName: json["firstName"],
        lastName: json["lastName"],
        middleName: json["middleName"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "middleName": middleName,
      };
}
