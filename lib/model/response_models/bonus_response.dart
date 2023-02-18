// To parse this JSON data, do
//
//     final bonuResponse = bonuResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

BonuResponse bonuResponseFromJson(String str) =>
    BonuResponse.fromJson(json.decode(str));

String bonuResponseToJson(BonuResponse data) => json.encode(data.toJson());

class BonuResponse extends BaseResponse {
  BonuResponse({this.bonus, message, baseStatus})
      : super(baseStatus: baseStatus, message: message);

  List<Bonus>? bonus;

  factory BonuResponse.fromJson(Map<String, dynamic> json) => BonuResponse(
      bonus: List<Bonus>.from(json["bonus"].map((x) => Bonus.fromJson(x))),
      message: json["message"] ?? "",
      baseStatus: json["baseStatus"] ?? true);

  Map<String, dynamic> toJson() => {
        "bonus": List<dynamic>.from(bonus!.map((x) => x.toJson())),
        "message": message,
        "baseStatus": baseStatus,
      };
}

class Bonus {
  Bonus({
    this.id,
    this.transactionId,
    this.pokedOn,
    this.createdAt,
    this.dateOfTransaction,
    this.referralBonusId,
    this.threshold,
    this.referralBonus,
    this.description,
    this.amount,
    this.useraccount,
  });

  int? id;
  String? transactionId;
  String? pokedOn;
  String? dateOfTransaction;
  String? createdAt;
  int? referralBonusId;
  String? description;
  ReferralBonus? referralBonus;
  Threshold? threshold;
  double? amount;
  Useraccount? useraccount;

  Bonus.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    if (json["transactionId"] != null) {
      transactionId = json["transactionId"];
    }
    if (json["pokedOn"] != null) {
      pokedOn = json["pokedOn"];
    }
    if (json["dateOfTransaction"] != null) {
      dateOfTransaction = json["dateOfTransaction"];
    }
    if (json["createdAt"] != null) {
      createdAt = json["createdAt"];
    }
    if (json["referralBonusId"] != null) {
      referralBonusId = json["referralBonusId"];
    }
    if (json["description"] != null) {
      description = json["description"];
    }

    if (json["referralBonus"] != null) {
      referralBonus = ReferralBonus.fromJson(json["referralBonus"]);
    }
    if (json["threshold"] != null) {
      threshold = Threshold.fromJson(json["threshold"]);
    }
    // amount = json["amount"] != null ? json["amount"] : null;
    if (json["amount"] != null) {
      amount = json["amount"];
    }
    if (json["useraccount"] != null) {
      useraccount = Useraccount.fromJson(json["useraccount"]);
    }
    // useraccount = json["useraccount"] != null ? json["useraccount"] : null;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "transactionId": transactionId,
        "pokedOn": pokedOn,
        "dateOfTransaction": dateOfTransaction,
        "createdAt": createdAt,
        "referralBonusId": referralBonusId,
        "referralBonus": referralBonus!.toJson(),
        "threshold": threshold!.toJson(),
        "description": description,
        "amount": amount,
        "useraccount": useraccount!.toJson(),
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
  dynamic? poker;
  dynamic? pokedUser;

  ReferralBonus.fromJson(Map<String, dynamic> json) {
    if (json["id"] != null) {
      id = json["id"];
    }
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
    if (json["poker"] != null) {
      poker = json["poker"];
    }
    if (json["pokedUser"] != null) {
      pokedUser = json["pokedUser"];
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

class Threshold {
  Threshold({
    this.id,
    this.amount,
    this.status,
    this.createdAt,
  });

  int? id;
  double? amount;
  String? status;
  String? createdAt;

  Threshold.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    if (json["amount"] != null) {
      amount = json["amount"];
    }

    if (json["status"] != null) {
      status = json["status"];
    }

    if (json["createdAt"] != null) {
      createdAt = json["createdAt"];
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "status": status,
        "createdAt": createdAt,
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
    this.source,
    this.sourceOthers,
    this.referralCode,
    this.referralLog,
    this.createdAt,
    this.individualUser,
    this.company,
    this.administrator,
    this.virtualAccountName,
    this.virtualAccountNo,
    this.businessType,
    this.kyc,
    this.assited,
    this.newsLetters,
    this.myReferralCode,
    this.referralLink,
    this.referralBonus,
  });

  int? id;
  String? phone;
  String? email;
  String? status;
  String? role;
  String? usage;
  String? source;
  SourceOther? sourceOthers;
  String? referralCode;
  String? referralLog;
  String? createdAt;
  dynamic? individualUser;
  dynamic? company;
  String? administrator;
  String? virtualAccountName;
  String? virtualAccountNo;
  String? businessType;
  bool? kyc;
  bool? assited;
  bool? newsLetters;
  String? myReferralCode;
  String? referralLink;
  dynamic? referralBonus;
  Useraccount.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    phone = json["phone"];
    email = json["email"];
    status = json["status"];
    role = json["role"];
    if (json["usage"] != null) {
      usage = json["usage"];
    }

    if (json["source"] != null) {
      source = json["source"];
    }

    // if (json["sourceOthers"] != null) {
    //   sourceOthers = json["sourceOthers"];
    // }
    sourceOthers = json["sourceOthers"] != null
        ? SourceOther.fromJson(json["sourceOthers"])
        : null;

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
    if (json["referralBonus"] != null) {
      referralBonus = json["referralBonus"];
    }
    if (json["referralLink"] != null) {
      referralLink = json["referralLink"];
    }
    if (json["myReferralCode"] != null) {
      myReferralCode = json["myReferralCode"];
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
    if (json["businessType"] != null) {
      businessType = json["businessType"];
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "email": email,
        "status": status,
        "role": role,
        "usage": usage,
        "source": source,
        "sourceOthers": sourceOthers,
        "referralCode": referralCode,
        "referralLog": referralLog,
        "createdAt": createdAt,
        "individualUser": individualUser,
        "company": company,
        "administrator": administrator,
        "virtualAccountName": virtualAccountName,
        "virtualAccountNo": virtualAccountNo,
        "businessType": businessType,
        "myReferralCode": myReferralCode,
        "referralLink": referralLink,
        "referralBonus": referralBonus,
        "kyc": kyc,
        "assited": assited,
        "newsLetters": newsLetters,
      };
}

class SourceOther {
  SourceOther({
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

  SourceOther.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    description = json["description"];
    status = json["status"];
    createdAt = json["createdAt"];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "status": status,
        "createdAt": createdAt,
      };
}
