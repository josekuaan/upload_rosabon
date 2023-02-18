// To parse this JSON data, do
//
//     final updateAccountResponse = updateAccountResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

UpdateAccountResponse? updateAccountResponseFromJson(String str) =>
    UpdateAccountResponse.fromJson(json.decode(str));

String updateAccountResponseToJson(UpdateAccountResponse? data) =>
    json.encode(data!.toJson());

class UpdateAccountResponse extends BaseResponse {
  UpdateAccountResponse(
      {this.id,
      this.accountName,
      this.accountNumber,
      this.status,
      this.transferRecipientCode,
      this.bank,
      this.useraccount,
      baseStatus,
      message})
      : super(baseStatus: baseStatus, message: message);

  int? id;
  String? accountName;
  String? accountNumber;
  String? status;
  dynamic transferRecipientCode;
  Banks? bank;
  Useraccount? useraccount;

  factory UpdateAccountResponse.fromJson(Map<String, dynamic> json) =>
      UpdateAccountResponse(
          id: json["id"],
          accountName: json["accountName"],
          accountNumber: json["accountNumber"],
          status: json["status"],
          transferRecipientCode: json["transferRecipientCode"],
          bank: Banks.fromJson(json["bank"]),
          useraccount: Useraccount.fromJson(json["useraccount"]),
          message: json["message"] ?? "",
          baseStatus: json["baseStatus"] ?? true);

  Map<String, dynamic> toJson() => {
        "id": id,
        "accountName": accountName,
        "accountNumber": accountNumber,
        "status": status,
        "transferRecipientCode": transferRecipientCode,
        "bank": bank!.toJson(),
        "useraccount": useraccount!.toJson(),
        "message": message,
        "baseStatus": baseStatus,
      };
}

class Banks {
  Banks({
    this.id,
    this.name,
    this.code,
  });

  int? id;
  String? name;
  String? code;

  factory Banks.fromJson(Map<String, dynamic> json) => Banks(
        id: json["id"],
        name: json["name"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
      };
}

class Useraccount {
  Useraccount({
    this.id,
    this.phone,
    this.email,
    this.status,
    this.role,
    this.usage,
    this.creationSource,
    this.source,
    this.sourceOthers,
    this.sourceNotInTheList,
    this.loginCount,
    this.referralCode,
    this.referralLog,
    this.createdAt,
    this.individualUser,
    this.myReferralCode,
    this.referralLink,
    this.referralBonus,
    this.company,
    this.administrator,
    this.virtualAccountName,
    this.virtualAccountNo,
    this.userType,
    this.department,
    this.businessUnit,
    this.kyc,
    this.assited,
    this.newsLetters,
  });

  int? id;
  String? phone;
  String? email;
  String? status;
  String? role;
  String? usage;
  String? creationSource;
  String? source;
  SourceOthers? sourceOthers;
  dynamic sourceNotInTheList;
  int? loginCount;
  dynamic referralCode;
  dynamic referralLog;
  String? createdAt;
  dynamic individualUser;
  dynamic company;
  String? myReferralCode;
  String? referralLink;
  ReferralBonus? referralBonus;
  String? administrator;
  String? virtualAccountName;
  String? virtualAccountNo;
  String? userType;
  String? department;
  String? businessUnit;
  bool? kyc;
  bool? assited;
  bool? newsLetters;

  Useraccount.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    phone = json["phone"];
    email = json["email"];
    status = json["status"];
    if (json["role"] != null) {
      role = json["role"];
    }
    if (json["creationSource"] != null) {
      creationSource = json["creationSource"];
    }
    if (json["usage"] != null) {
      usage = json["usage"];
    }
    if (json["loginCount"] != null) {
      loginCount = json["loginCount"];
    }

    sourceOthers = json["sourceOthers"] != null
        ? SourceOthers.fromJson(json["sourceOthers"])
        : null;
    if (json["source"] != null) {
      source = json["source"];
    }
    if (json["sourceNotInTheList"] != null) {
      sourceNotInTheList = json["sourceNotInTheList"];
    }

    if (json["newsLetters"] != null) {
      newsLetters = json["newsLetters"];
    }

    if (json["kyc"] != null) {
      kyc = json["kyc"];
    }

    if (json["assited"] != null) {
      assited = json["assited"];
    }

    if (json["referralLog"] != null) {
      referralLog = json["referralLog"];
    }
    if (json["referralCode"] != null) {
      referralCode = json["referralCode"];
    }
    if (json["myReferralCode"] != null) {
      myReferralCode = json["myReferralCode"];
    }
    if (json["referralLink"] != null) {
      referralLink = json["referralLink"];
    }

    if (json["createdAt"] != null) {
      createdAt = json["createdAt"];
    }
    if (json["individualUser"] != null) {
      individualUser = json["individualUser"];
    }
    if (json["company"] != null) {
      company = json["company"];
    }

    if (json["administrator"] != null) {
      administrator = json["administrator"];
    }

    if (json["virtualAccountName"] != null) {
      virtualAccountName = json["virtualAccountName"];
    }
    if (json["virtualAccountNo"] != null) {
      virtualAccountNo = json["virtualAccountNo"];
    }
    if (json["department"] != null) {
      department = json["department"];
    }
    if (json["businessUnit"] != null) {
      businessUnit = json["businessUnit"];
    }
    
    referralBonus = json["referralBonus"] != null
        ? ReferralBonus.fromJson(json["referralBonus"])
        : null;
   
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "email": email,
        "status": status,
        "role": role,
        "usage": usage,
        "creationSource": creationSource,
        "source": source,
        "sourceOthers": sourceOthers!.toJson(),
        "sourceNotInTheList": sourceNotInTheList,
        "loginCount": loginCount,
        "referralCode": referralCode,
        "referralLog": referralLog,
        "createdAt": createdAt,
        "individualUser": individualUser,
        "company": company,
        "myReferralCode": myReferralCode,
        "referralLink": referralLink,
        "referralBonus": referralBonus!.toJson(),
        "administrator": administrator,
        "virtualAccountName": virtualAccountName,
        "virtualAccountNo": virtualAccountNo,
        "userType": userType,
        "department": department,
        "businessUnit": businessUnit,
        "kyc": kyc,
        "assited": assited,
        "newsLetters": newsLetters,
      };
}

class ReferralBonus {
  ReferralBonus({
    this.id,
    this.totalRedeemedBonus,
    this.earnedReferralBonus,
    this.description,
    this.createdAt,
    this.poker,
    this.pokedUser,
  });

  int? id;
  double? totalRedeemedBonus;
  double? earnedReferralBonus;
  String? description;
  String? createdAt;
  dynamic poker;
  dynamic pokedUser;

  ReferralBonus.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    if (json["totalRedeemedBonus"] != null) {
      totalRedeemedBonus = json["totalRedeemedBonus"];
    }
    if (json["earnedReferralBonus"] != null) {
      earnedReferralBonus = json["earnedReferralBonus"];
    }
    if (json["description"] != null) {
      description = json["description"];
    }
    if (json["createdAt"] != null) {
      createdAt = json["createdAt"];
    }
    if (json["pokedUser"] != null) {
      pokedUser = json["pokedUser"];
    }
    if (json["poker"] != null) {
      poker = json["poker"];
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "totalRedeemedBonus": totalRedeemedBonus,
        "earnedReferralBonus": earnedReferralBonus,
        "description": description,
        "createdAt": createdAt,
        "poker": poker,
        "pokedUser": pokedUser,
      };
}

class SourceOthers {
  SourceOthers({
    this.id,
    this.name,
    this.description,
    this.status,
    this.createdAt,
  });

  int? id;
  String? name;
  String? description;
  String? status;
  String? createdAt;

  factory SourceOthers.fromJson(Map<String, dynamic> json) => SourceOthers(
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
