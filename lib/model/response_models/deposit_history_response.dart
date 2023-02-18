// To parse this JSON data, do
//
//     final depositHistoryResponse = depositHistoryResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

DepositHistoryResponse depositHistoryResponseFromJson(String str) =>
    DepositHistoryResponse.fromJson(json.decode(str));

String depositHistoryResponseToJson(DepositHistoryResponse data) =>
    json.encode(data.toJson());

class DepositHistoryResponse extends BaseResponse {
  DepositHistoryResponse({this.deposit, message, baseStatus})
      : super(baseStatus: baseStatus, message: message);

  List<Deposit>? deposit;

  factory DepositHistoryResponse.fromJson(Map<String, dynamic> json) =>
      DepositHistoryResponse(
        deposit:
            List<Deposit>.from(json["deposit"].map((x) => Deposit.fromJson(x))),
        message: json["message"] ?? "",
        baseStatus: json["baseStatus"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "deposit": List<dynamic>.from(deposit!.map((x) => x.toJson())),
        "message": message,
        "baseStatus": baseStatus,
      };
}

class Deposit {
  Deposit({
    this.id,
    this.transactionId,
    this.transactionDate,
    this.category,
    this.transactionType,
    this.description,
    this.amount,
    this.balance,
    this.useraccount,
    this.createdAt,
  });

  int? id;
  int? transactionId;
  String? transactionDate;
  String? category;
  String? transactionType;
  String? description;
  double? amount;
  double? balance;
  Useraccount? useraccount;
  String? createdAt;

  Deposit.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    if (json["transactionId"] != null) {
      transactionId = json["transactionId"];
    }
    if (json["transactionDate"] != null) {
      transactionDate = json["transactionDate"];
    }
    if (json["category"] != null) {
      category = json["category"];
    }
    if (json["transactionType"] != null) {
      transactionType = json["transactionType"];
    }
    if (json["description"] != null) {
      description = json["description"];
    }
    if (json["amount"] != null) {
      amount = json["amount"];
    }
    if (json["balance"] != null) {
      balance = json["balance"];
    }
    if (json["useraccount"] != null) {
      useraccount = Useraccount.fromJson(json["useraccount"]);
    }
    if (json["createdAt"] != null) {
      createdAt = json["createdAt"];
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "transactionId": transactionId,
        "transactionDate": transactionDate,
        "category": category,
        "transactionType": transactionType,
        "description": description,
        "amount": amount,
        "balance": balance,
        "useraccount": useraccount!.toJson(),
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
    this.myReferralCode,
    this.referralLink,
    this.referralBonus,
    this.company,
    this.administrator,
    this.virtualAccountName,
    this.virtualAccountNo,
    this.businessType,
    this.assited,
    this.newsLetters,
    this.kyc,
  });

  int? id;
  String? phone;
  String? email;
  String? status;
  String? role;
  String? usage;
  String? source;
  SourceOthers? sourceOthers;
  String? referralCode;
  String? referralLog;
  String? createdAt;
  dynamic? individualUser;
  String? myReferralCode;
  String? referralLink;
  ReferralBonus? referralBonus;
  dynamic? company;
  String? administrator;
  String? virtualAccountName;
  String? virtualAccountNo;
  String? businessType;
  bool? assited;
  bool? newsLetters;
  bool? kyc;

  Useraccount.fromJson(Map<String, dynamic> json) {
    {
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
      if (json["sourceOthers"] != null) {
        // sourceOthers = json["sourceOthers"];/
        sourceOthers = SourceOthers.fromJson(json["sourceOthers"]);

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
      if (json["referralBonus"] != null) {
        referralBonus = ReferralBonus.fromJson(json["referralBonus"]);
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
        "myReferralCode": myReferralCode,
        "referralLink": referralLink,
        "referralBonus": referralBonus!.toJson(),
        "company": company,
        "administrator": administrator,
        "virtualAccountName": virtualAccountName,
        "virtualAccountNo": virtualAccountNo,
        "businessType": businessType,
        "assited": assited,
        "newsLetters": newsLetters,
        "kyc": kyc,
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
