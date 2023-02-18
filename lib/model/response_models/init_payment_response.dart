// To parse this JSON data, do
//
//     final initPaymentResponse = initPaymentResponseFromJson(jsonString);

import 'dart:convert';

InitPaymentResponse initPaymentResponseFromJson(String str) =>
    InitPaymentResponse.fromJson(json.decode(str));

String initPaymentResponseToJson(InitPaymentResponse data) =>
    json.encode(data.toJson());

class InitPaymentResponse {
  InitPaymentResponse({
    this.id,
    this.transactionReference,
    this.totalAmount,
    this.convenienceCharge,
    this.registrationDate,
    this.executionDate,
    this.paymentStatus,
    this.transactionStatus,
    this.bankAccountFundingStatus,
    this.transactionDescription,
    this.purposeOfPayment,
    this.valueStatus,
    this.payer,
    this.paymentGateway,
  });

  int? id;
  String? transactionReference;
  int? totalAmount;
  dynamic? convenienceCharge;
  String? registrationDate;
  dynamic? executionDate;
  String? paymentStatus;
  String? transactionStatus;
  String? bankAccountFundingStatus;
  String? transactionDescription;
  String? purposeOfPayment;
  String? valueStatus;
  Payer? payer;
  String? paymentGateway;

  InitPaymentResponse.fromJson(Map<String, dynamic> json) {
    if (json["id"] != null) {
      id = json["id"];
    }
    if (json["transactionReference"] != null) {
      transactionReference = json["transactionReference"];
    }
    if (json["totalAmount"] != null) {
      totalAmount = json["totalAmount"];
    }
    if (json["convenienceCharge"] != null) {
      convenienceCharge = json["convenienceCharge"];
    }
    if (json["registrationDate"] != null) {
      registrationDate = json["registrationDate"];
    }
    if (json["executionDate"] != null) {
      executionDate = json["executionDate"];
    }
    if (json["paymentStatus"] != null) {
      paymentStatus = json["paymentStatus"];
    }
    if (json["transactionStatus"] != null) {
      transactionStatus = json["transactionStatus"];
    }
    if (json["bankAccountFundingStatus"] != null) {
      bankAccountFundingStatus = json["bankAccountFundingStatus"];
    }
    if (json["transactionDescription"] != null) {
      transactionDescription = json["transactionDescription"];
    }
    if (json["purposeOfPayment"] != null) {
      purposeOfPayment = json["purposeOfPayment"];
    }
    if (json["valueStatus"] != null) {
      valueStatus = json["valueStatus"];
    }
    if (json["payer"] != null) {
      payer = Payer.fromJson(json["payer"]);
    }
    if (json["paymentGateway"] != null) {
      paymentGateway = json["paymentGateway"];
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "transactionReference": transactionReference,
        "totalAmount": totalAmount,
        "convenienceCharge": convenienceCharge,
        "registrationDate": registrationDate,
        "executionDate": executionDate,
        "paymentStatus": paymentStatus,
        "transactionStatus": transactionStatus,
        "bankAccountFundingStatus": bankAccountFundingStatus,
        "transactionDescription": transactionDescription,
        "purposeOfPayment": purposeOfPayment,
        "valueStatus": valueStatus,
        "payer": payer!.toJson(),
        "paymentGateway": paymentGateway,
      };
}

class Payer {
  Payer({
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
  String? sourceOthers;
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

  Payer.fromJson(Map<String, dynamic> json) {
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
        sourceOthers = json["sourceOthers"];
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
  int? totalRedeemedBonus;
  int? earnedReferralBonus;
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
