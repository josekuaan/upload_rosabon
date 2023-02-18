// To parse this JSON data, do
//
//     final investmentRateResponse = investmentRateResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

InvestmentRateResponse investmentRateResponseFromJson(String str) =>
    InvestmentRateResponse.fromJson(json.decode(str));

String investmentRateResponseToJson(InvestmentRateResponse data) =>
    json.encode(data.toJson());

class InvestmentRateResponse extends BaseResponse {
  InvestmentRateResponse({this.investmentValue, message, baseStatus})
      : super(baseStatus: baseStatus, message: message);

  List<InvestmentValue>? investmentValue;

  InvestmentRateResponse.fromJson(Map<String, dynamic> json) {
    investmentValue = List<InvestmentValue>.from(
        json["body"].map((x) => InvestmentValue.fromJson(x)));
    
    baseStatus = json["baseStatus"] ?? true;
    message = json["message"] ?? '';
  }

  Map<String, dynamic> toJson() => {
        "investmentValue":
            List<dynamic>.from(investmentValue!.map((x) => x.toJson())),
        "message": message,
        "baseStatus": baseStatus,
      };
}

class InvestmentValue {
  InvestmentValue({
    this.id,
    this.product,
    this.investmentCurrency,
    this.minimumAmount,
    this.maximumAmount,
    this.minimumTenor,
    this.maximumTenor,
    this.status,
    this.upfrontInterestRate,
    this.monthlyInterestRate,
    this.quarterlyInterestRate,
    this.biAnnualInterestRate,
    this.maturityRate,
    this.backendUpfrontInterestRate,
    this.backendMonthlyInterestRate,
    this.backendQuarterlyInterestRate,
    this.backendBiAnnualInterestRate,
    this.backendMaturityRate,
    this.percentDirectDebit,
    this.dateAdded,
  });

  int? id;
  InvestmentProduct? product;
  InvestmentCurrency? investmentCurrency;
  double? minimumAmount;
  double? maximumAmount;
  int? minimumTenor;
  int? maximumTenor;
  String? status;
  dynamic? upfrontInterestRate;
  dynamic? monthlyInterestRate;
  dynamic? quarterlyInterestRate;
  dynamic? biAnnualInterestRate;
  dynamic? maturityRate;
  dynamic? backendUpfrontInterestRate;
  dynamic? backendMonthlyInterestRate;
  dynamic? backendQuarterlyInterestRate;
  dynamic? backendBiAnnualInterestRate;
  dynamic? backendMaturityRate;
  dynamic? percentDirectDebit;
  DateTime? dateAdded;

  InvestmentValue.fromJson(Map<String, dynamic> json) {
    id = json["id"];

    product = json["product"] != null
        ? InvestmentProduct.fromJson(json["product"])
        : null;

    investmentCurrency = json["currency"] != null
        ? InvestmentCurrency.fromJson(json["currency"])
        : null;

    if (json["minimumAmount"] != null) {
      minimumAmount = json["minimumAmount"];
    }
    if (json["maximumAmount"] != null) {
      maximumAmount = json["maximumAmount"];
    }
    if (json["minimumTenor"] != null) {
      minimumTenor = json["minimumTenor"];
    }
    if (json["maximumTenor"] != null) {
      maximumTenor = json["maximumTenor"];
    }
    if (json["status"] != null) {
      status = json["status"];
    }
    if (json["upfrontInterestRate"] != null) {
      upfrontInterestRate = json["upfrontInterestRate"];
    }
    if (json["monthlyInterestRate"] != null) {
      monthlyInterestRate = json["monthlyInterestRate"];
    }
    if (json["quarterlyInterestRate"] != null) {
      quarterlyInterestRate = json["quarterlyInterestRate"];
    }
    if (json["biAnnualInterestRate"] != null) {
      biAnnualInterestRate = json["biAnnualInterestRate"];
    }
    if (json["maturityRate"] != null) {
      maturityRate = json["maturityRate"];
    }
    if (json["backendUpfrontInterestRate"] != null) {
      backendUpfrontInterestRate = json["backendUpfrontInterestRate"];
    }
    if (json["backendMonthlyInterestRate"] != null) {
      backendMonthlyInterestRate = json["backendMonthlyInterestRate"];
    }
    if (json["backendQuarterlyInterestRate"] != null) {
      backendQuarterlyInterestRate = json["backendQuarterlyInterestRate"];
    }
    if (json["backendBiAnnualInterestRate"] != null) {
      backendBiAnnualInterestRate = json["backendBiAnnualInterestRate"];
    }
    if (json["backendMaturityRate"] != null) {
      backendMaturityRate = json["backendMaturityRate"];
    }
    if (json["percentDirectDebit"] != null) {
      percentDirectDebit = json["percentDirectDebit"];
    }

    dateAdded =
        json["dateAdded"] != null ? DateTime.parse(json["dateAdded"]) : null;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product!.toJson(),
        "currency": investmentCurrency!.toJson(),
        "minimumAmount": minimumAmount,
        "maximumAmount": maximumAmount,
        "minimumTenor": minimumTenor,
        "maximumTenor": maximumTenor,
        "status": status,
        "upfrontInterestRate": upfrontInterestRate,
        "monthlyInterestRate": monthlyInterestRate,
        "quarterlyInterestRate": quarterlyInterestRate,
        "biAnnualInterestRate": biAnnualInterestRate,
        "maturityRate": maturityRate,
        "backendUpfrontInterestRate": backendUpfrontInterestRate,
        "backendMonthlyInterestRate": backendMonthlyInterestRate,
        "backendQuarterlyInterestRate": backendQuarterlyInterestRate,
        "backendBiAnnualInterestRate": backendBiAnnualInterestRate,
        "backendMaturityRate": backendMaturityRate,
        "percentDirectDebit": percentDirectDebit,
        "dateAdded":
            "${dateAdded!.year.toString().padLeft(4, '0')}-${dateAdded!.month.toString().padLeft(2, '0')}-${dateAdded!.day.toString().padLeft(2, '0')}",
      };
}

class InvestmentProduct {
  InvestmentProduct({
    this.id,
    this.createdDate,
    this.productName,
    this.productCode,
    this.productCategory,
    this.minTransactionLimit,
    this.maxTransactionLimit,
    this.tenorDisplayIn,
    this.status,
    this.productDescription,
    this.imageUrl,
    this.currency,
    this.properties,
    this.tenors,
    this.allowCustomization,
  });

  int? id;
  DateTime? createdDate;
  String? productName;
  String? productCode;
  dynamic? productCategory;
  double? minTransactionLimit;
  double? maxTransactionLimit;
  String? tenorDisplayIn;
  String? status;
  String? productDescription;
  String? imageUrl;
  Properties? properties;
  InvestmentCurrency? currency;

  dynamic? tenors;
  bool? allowCustomization;

  InvestmentProduct.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    // if (json["actualMaturityDate"] != null) {
    //   actualMaturityDate = DateTime.parse(json["actualMaturityDate"]);
    // }

    createdDate = json["createdDate"] != null
        ? DateTime.parse(json["createdDate"])
        : null;

    if (json["productCode"] != null) {
      productCode = json["productCode"];
    }
    if (json["productName"] != null) {
      productName = json["productName"];
    }
    if (json["productCategory"] != null) {
      productCategory = json["productCategory"];
    }
    if (json["minTransactionLimit"] != null) {
      minTransactionLimit = json["minTransactionLimit"];
    }
    if (json["maxTransactionLimit"] != null) {
      maxTransactionLimit = json["maxTransactionLimit"];
    }

    if (json["tenorDisplayIn"] != null) {
      tenorDisplayIn = json["tenorDisplayIn"];
    }
    if (json["status"] != null) {
      status = json["status"];
    }
    if (json["productDescription"] != null) {
      productDescription = json["productDescription"];
    }
    if (json["imageUrl"] != null) {
      imageUrl = json["imageUrl"];
    }

    if (json["tenors"] != null) {
      tenors = json["tenors"];
    }
    if (json["properties"] != null) {
      properties = Properties.fromJson(json["properties"]);
    }

    currency = json["currency"] != null
        ? InvestmentCurrency.fromJson(json["currency"])
        : null;

    if (json["tenor"] != null) {
      tenors = json["tenor"];
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate":
            "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
        "productName": productName,
        "productCode": productCode,
        "productCategory": productCategory,
        "minTransactionLimit": minTransactionLimit,
        "maxTransactionLimit": maxTransactionLimit,
        "tenorDisplayIn": tenorDisplayIn,
        "status": status,
        "productDescription": productDescription,
        "imageUrl": imageUrl,
        "properties": properties!.toJson(),
        "currency": currency!.toJson(),
        "tenors": tenors,
        "allowCustomization": allowCustomization,
      };
}

class InvestmentCurrency {
  InvestmentCurrency({
    this.id,
    this.name,
    this.status,
    this.dateAdded,
  });

  int? id;
  String? name;
  String? status;
  DateTime? dateAdded;

  InvestmentCurrency.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    if (json["name"] != null) {
      name = json["name"];
    }
    if (json["status"] != null) {
      status = json["status"];
    }
    if (json["dateAdded"] != null) {
      dateAdded = DateTime.parse(json["dateAdded"]);
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "dateAdded":
            "${dateAdded!.year.toString().padLeft(4, '0')}-${dateAdded!.month.toString().padLeft(2, '0')}-${dateAdded!.day.toString().padLeft(2, '0')}",
      };
}

class Properties {
  Properties({
    this.id,
    this.hasTargetAmount,
    this.hasContributionValue,
    this.hasSavingFrequency,
    this.allowsDirectDebit,
    this.paymentType,
    this.allowsMonthlyDraw,
    this.acceptsRollover,
    this.allowsLiquidation,
    this.allowsTransfer,
    this.receivesTransfer,
    this.allowsTopUp,
    this.tenorInDays,
    this.tenorInYears,
    // this.interestOption,
    this.interestFormula,
    this.penaltyFormula,
    this.createdDate,
  });

  int? id;
  bool? hasTargetAmount;
  bool? hasContributionValue;
  bool? hasSavingFrequency;
  bool? allowsDirectDebit;
  String? paymentType;
  bool? allowsMonthlyDraw;
  bool? acceptsRollover;
  bool? allowsLiquidation;
  bool? allowsTransfer;
  bool? receivesTransfer;
  bool? allowsTopUp;
  int? tenorInDays;
  int? tenorInYears;
  // InterestOption? interestOption;
  String? interestFormula;
  String? penaltyFormula;
  DateTime? createdDate;

  Properties.fromJson(Map<String, dynamic> json) {
    print("===========================55555555555555");
    id = json["id"];
    if (json["hasTargetAmount"] != null) {
      hasTargetAmount = json["hasTargetAmount"];
    }
    if (json["hasContributionValue"] != null) {
      hasContributionValue = json["hasContributionValue"];
    }
    if (json["hasSavingFrequency"] != null) {
      hasSavingFrequency = json["hasSavingFrequency"];
    }
    if (json["allowsDirectDebit"] != null) {
      allowsDirectDebit = json["allowsDirectDebit"];
    }
    print("===========================55555555555555");
    if (json["paymentType"] != null) {
      paymentType = json["paymentType"];
    }
    if (json["allowsMonthlyDraw"] != null) {
      allowsMonthlyDraw = json["allowsMonthlyDraw"];
    }
    if (json["acceptsRollover"] != null) {
      acceptsRollover = json["acceptsRollover"];
    }
    if (json["allowsLiquidation"] != null) {
      allowsLiquidation = json["allowsLiquidation"];
    }
    if (json["allowsTransfer"] != null) {
      allowsTransfer = json["allowsTransfer"];
    }
    if (json["allowsTopUp"] != null) {
      allowsTopUp = json["allowsTopUp"];
    }
    if (json["tenorInDays"] != null) {
      tenorInDays = json["tenorInDays"];
    }
    if (json["tenorInYears"] != null) {
      tenorInYears = json["tenorInYears"];
    }
    if (json["penaltyFormula"] != null) {
      penaltyFormula = json["penaltyFormula"];
    }
    if (json["interestFormula"] != null) {
      interestFormula = json["interestFormula"];
    }
    print("===========================55555555555555");
    // interestOption = InterestOption.fromJson(json["interestOptions"]);

    createdDate = json["createdDate"] != null
        ? DateTime.parse(json["createdDate"])
        : null;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "hasTargetAmount": hasTargetAmount,
        "hasContributionValue": hasContributionValue,
        "hasSavingFrequency": hasSavingFrequency,
        "allowsDirectDebit": allowsDirectDebit,
        "paymentType": paymentType,
        "allowsMonthlyDraw": allowsMonthlyDraw,
        "acceptsRollover": acceptsRollover,
        "allowsLiquidation": allowsLiquidation,
        "allowsTransfer": allowsTransfer,
        "receivesTransfer": receivesTransfer,
        "allowsTopUp": allowsTopUp,
        "tenorInDays": tenorInDays,
        "tenorInYears": tenorInYears,
        // "interestOption": interestOption!.toJson(),
        "interestFormula": interestFormula,
        "penaltyFormula": penaltyFormula,
        "createdDate":
            "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
      };
}
