// To parse this JSON data, do
//
//     final transactionResponse = transactionResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

TransactionResponse transactionResponseFromJson(String str) =>
    TransactionResponse.fromJson(json.decode(str));

String transactionResponseToJson(TransactionResponse data) =>
    json.encode(data.toJson());

class TransactionResponse extends BaseResponse {
  TransactionResponse({this.transaction, baseStatus, message})
      : super(baseStatus: baseStatus, message: message);

  List<Transaction>? transaction;

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      TransactionResponse(
          transaction: List<Transaction>.from(
              json["transaction"].map((x) => Transaction.fromJson(x))),
          baseStatus: json["baseStatus"] ?? true,
          message: json["message"] ?? '');

  Map<String, dynamic> toJson() => {
        "transaction": List<dynamic>.from(transaction!.map((x) => x.toJson())),
        "baseStatus": baseStatus,
        "message": message,
      };
}

class Transaction {
  Transaction({
    this.id,
    this.transactionId,
    this.transactionDate,
    this.description,
    this.transactionCategory,
    this.credit,
    this.debit,
    this.balanceAfterTransaction,
    this.transactionType,
    this.useraccount,
  });

  int? id;
  String? transactionId;
  String? transactionDate;
  String? description;
  String? transactionCategory;
  double? credit;
  double? debit;
  double? balanceAfterTransaction;
  String? transactionType;
  Useraccount? useraccount;

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    if (json["transactionId"] != null) {
      transactionId = json["transactionId"];
    }

    if (json["transactionDate"] != null) {
      transactionDate = json["transactionDate"];
    }

    if (json["description"] != null) {
      description = json["description"];
    }
    if (json["transactionCategory"] != null) {
      transactionCategory = json["transactionCategory"];
    }
    if (json["credit"] != null) {
      credit = json["credit"];
    }

    if (json["debit"] != null) {
      debit = json["debit"];
    }
    if (json["balanceAfterTransaction"] != null) {
      balanceAfterTransaction = json["balanceAfterTransaction"];
    }
    if (json["transactionType"] != null) {
      transactionType = json["transactionType"];
    }

    useraccount = json["useraccount"] != null
        ? Useraccount.fromJson(json["useraccount"])
        : null;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "transactionId": transactionId,
        "transactionDate": transactionDate,
        "description": description,
        "transactionCategory": transactionCategory,
        "credit": credit,
        "debit": debit,
        "balanceAfterTransaction": balanceAfterTransaction,
        "transactionType": transactionType,
        "useraccount": useraccount!.toJson(),
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

