// To parse this JSON data, do
//
//     final planResponse = planResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

PlanResponse planResponseFromJson(String str) =>
    PlanResponse.fromJson(json.decode(str));

String planResponseToJson(PlanResponse data) => json.encode(data.toJson());

class PlanResponse extends BaseResponse {
  PlanResponse({this.plans, message, baseStatus})
      : super(baseStatus: baseStatus, message: message);

  List<Plan>? plans;

  PlanResponse.fromJson(Map<String, dynamic> json) {
    print(json);
    plans = List<Plan>.from(json["plans"].map((x) => Plan.fromJson(x)));
    baseStatus = json["baseStatus"] ?? true;
    message = json["message"] ?? "";
  }

  Map<String, dynamic> toJson() => {
        "Plans": List<dynamic>.from(plans!.map((x) => x.toJson())),
        "message": message,
        "baseStatus": baseStatus,
      };
}

class Plan {
  Plan({
    this.id,
    this.productPlan,
    this.actualMaturityDate,
    this.productCategory,
    this.planName,
    this.currency,
    this.exchangeRate,
    this.amountToBePlaced,
    this.targetAmount,
    this.tenor,
    this.planDate,
    this.savingFrequency,
    this.planStatus,
    this.weeklyContributionDay,
    this.monthlyContributionDay,
    this.interestReceiptOption,
    this.acceptPeriodicContribution,
    this.contributionValue,
    this.directDebit,
    this.interestRate,
    this.numberOfTickets,
    this.autoRenew,
    this.allowsLiquidation,
    this.planSummary,
    this.paymentMethod,
    this.createdDate,
    this.toppingUp,
  });

  int? id;
  ProductPlan? productPlan;
  DateTime? actualMaturityDate;
  Category? productCategory;
  String? planName;
  bool? toppingUp;
  Currency? currency;
  double? exchangeRate;
  double? amountToBePlaced;
  double? targetAmount;
  Tenor? tenor;
  DateTime? planDate;
  String? savingFrequency;
  String? planStatus;
  String? weeklyContributionDay;
  int? monthlyContributionDay;
  String? interestReceiptOption;
  bool? acceptPeriodicContribution;
  double? contributionValue;
  bool? directDebit;
  double? interestRate;
  int? numberOfTickets;
  bool? autoRenew;
  bool? allowsLiquidation;
  PlanSummary? planSummary;
  String? paymentMethod;
  DateTime? createdDate;

  Plan.fromJson(Map<String, dynamic> json) {
    if (json["id"] != null) {
      id = json["id"];
    }
    productPlan =
        json["product"] != null ? ProductPlan.fromJson(json["product"]) : null;
    productCategory = json["productCategory"] != null
        ? Category.fromJson(json["productCategory"])
        : null;

    if (json["planName"] != null) {
      planName = json["planName"];
    }
    currency =
        json["currency"] != null ? Currency.fromJson(json["currency"]) : null;
    exchangeRate = json["exchangeRate"];
    if (json["amountToBePlaced"] != null) {
      amountToBePlaced = json["amountToBePlaced"];
    }
    if (json["targetAmount"] != null) {
      targetAmount = json["targetAmount"];
    }
    if (json["toppingUp"] != null) {
      toppingUp = json["toppingUp"];
    }

    tenor = json["tenor"] != null ? Tenor.fromJson(json["tenor"]) : null;

    if (json["acceptPeriodicContribution"] != null) {
      acceptPeriodicContribution = json["acceptPeriodicContribution"];
    }
    planDate =
        json["planDate"] != null ? DateTime.parse(json["planDate"]) : null;
    if (json["savingFrequency"] != null) {
      savingFrequency = json["savingFrequency"];
    }

    if (json["planStatus"] != null) {
      planStatus = json["planStatus"];
    }
    if (json["actualMaturityDate"] != null) {
      actualMaturityDate = DateTime.parse(json["actualMaturityDate"]);
    }
    if (json["weeklyContributionDay"] != null) {
      weeklyContributionDay = json["weeklyContributionDay"];
    }
    if (json["monthlyContributionDay"] != null) {
      monthlyContributionDay = json["monthlyContributionDay"];
    }
    if (json["interestReceiptOption"] != null) {
      interestReceiptOption = json["interestReceiptOption"];
    }
    if (json["contributionValue"] != null) {
      contributionValue = json["contributionValue"].toDouble();
    }
    if (json["directDebit"] != null) {
      directDebit = json["directDebit"];
    }
    if (json["interestRate"] != null) {
      interestRate = json["interestRate"];
    }
    if (json["paymentType"] != null) {
      paymentMethod = json["paymentMethod"];
    }

    if (json["numberOfTickets"] != null) {
      numberOfTickets = json["numberOfTickets"];
    }
    if (json["autoRenew"] != null) {
      autoRenew = json["autoRenew"];
    }
    if (json["allowsLiquidation"] != null) {
      allowsLiquidation = json["allowsLiquidation"];
    }
    planSummary = PlanSummary.fromJson(json["planSummary"]);

    if (json["paymentMethod"] != null) {
      paymentMethod = json["paymentMethod"];
    }
    createdDate = json["createdDate"] != null
        ? DateTime.parse(json["createdDate"])
        : null;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "productPlan": productPlan!.toJson(),
        "actualMaturityDate":
            "${actualMaturityDate!.year.toString().padLeft(4, '0')}-${actualMaturityDate!.month.toString().padLeft(2, '0')}-${actualMaturityDate!.day.toString().padLeft(2, '0')}",
        "productCategory": productCategory!.toJson(),
        "planName": planName,
        "toppingUp": toppingUp,
        "currency": currency!.toJson(),
        "exchangeRate": exchangeRate,
        "amountToBePlaced": amountToBePlaced,
        "targetAmount": targetAmount,
        "tenor": tenor!.toJson(),
        "planDate":
            "${planDate!.year.toString().padLeft(4, '0')}-${planDate!.month.toString().padLeft(2, '0')}-${planDate!.day.toString().padLeft(2, '0')}",
        "savingFrequency": savingFrequency,
        "planStatus": planStatus,
        "weeklyContributionDay": weeklyContributionDay,
        "monthlyContributionDay": monthlyContributionDay,
        "interestReceiptOption": interestReceiptOption,
        "acceptPeriodicContribution": acceptPeriodicContribution,
        "contributionValue": contributionValue,
        "directDebit": directDebit,
        "interestRate": interestRate,
        "numberOfTickets": numberOfTickets,
        "autoRenew": autoRenew,
        "allowsLiquidation": allowsLiquidation,
        "planSummary": planSummary!.toJson(),
        "paymentMethod": paymentMethod,
        "createdDate":
            "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
      };
}

class PlanSummary {
  PlanSummary({
    this.planName,
    this.startDate,
    this.endDate,
    this.principal,
    this.interestRate,
    this.interestPaymentFrequency,
    this.calculatedInterest,
    this.withholdingTax,
    this.paymentMaturity,
    this.dailyInterestAccrued,
    this.withdrawalInProgress,
  });

  String? planName;
  DateTime? startDate;
  DateTime? endDate;
  double? principal;
  double? interestRate;
  String? interestPaymentFrequency;
  double? calculatedInterest;
  double? withholdingTax;
  double? paymentMaturity;
  double? dailyInterestAccrued;
  bool? withdrawalInProgress;

  PlanSummary.fromJson(Map<String, dynamic> json) {
    if (json["planName"] != null) {
      planName = json["planName"];
    }
    if (json["principal"] != null) {
      principal = json["principal"];
    }
    if (json["interestRate"] != null) {
      interestRate = json["interestRate"];
    }
    if (json["interestPaymentFrequency"] != null) {
      interestPaymentFrequency = json["interestPaymentFrequency"];
    }
    if (json["calculatedInterest"] != null) {
      calculatedInterest = json["calculatedInterest"];
    }
    if (json["withholdingTax"] != null) {
      withholdingTax = json["withholdingTax"];
    }
    if (json["paymentMaturity"] != null) {
      paymentMaturity = json["paymentMaturity"];
    }
    if (json["dailyInterestAccrued"] != null) {
      dailyInterestAccrued = json["dailyInterestAccrued"];
    }
    if (json["withdrawalInProgress"] != null) {
      withdrawalInProgress = json["withdrawalInProgress"];
    }

    endDate = json["endDate"] != null ? DateTime.parse(json["endDate"]) : null;
    startDate =
        json["startDate"] != null ? DateTime.parse(json["startDate"]) : null;
  }

  Map<String, dynamic> toJson() => {
        "planName": planName,
        "startDate":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "endDate":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "principal": principal,
        "interestRate": interestRate,
        "interestPaymentFrequency": interestPaymentFrequency,
        "calculatedInterest": calculatedInterest,
        "paymentMaturity": paymentMaturity,
        "withholdingTax": withholdingTax,
        "dailyInterestAccrued": dailyInterestAccrued,
        "withdrawalInProgress": withdrawalInProgress,
      };
}

class Category {
  Category({
    this.id,
    this.createdDate,
    this.description,
    this.name,
    this.status,
  });

  int? id;
  String? createdDate;
  String? description;
  String? name;
  String? status;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        createdDate: json['createdDate'],
        //  DateTime.parse(json["createdDate"]),
        description: json["description"],
        name: json["name"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": createdDate,
        // "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
        "description": description,
        "name": name,
        "status": status,
      };
}

class ProductPlan {
  ProductPlan({
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
  String? createdDate;
  String? productName;
  String? productCode;
  dynamic? productCategory;
  double? minTransactionLimit;
  double? maxTransactionLimit;
  dynamic? tenorDisplayIn;
  String? status;
  String? productDescription;
  String? imageUrl;
  Currency? currency;
  Properties? properties;
  Tenor? tenors;
  bool? allowCustomization;

  ProductPlan.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    // createdDate = json["createdDate"],
    //  DateTime.parse(json["createdDate"]);
    productName = json["productName"];
    if (json["productCode"] != null) {
      productCode = json["productCode"];
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
    if (json["imageUrl"] != null) {
      imageUrl = json["imageUrl"];
    }
    if (json["productDescription"] != null) {
      productDescription = json["productDescription"];
    }
    if (json["status"] != null) {
      status = json["status"];
    }
    if (json["properties"] != null) {
      properties = Properties.fromJson(json["properties"]);
    }
    if (json["currency"] != null) {
      currency = Currency.fromJson(json["currency"]);
    }
    if (json["allowCustomization"] != null) {
      allowCustomization = json["allowCustomization"];
    }
    if (json["tenors"] != null) {
      tenors = Tenor.fromJson(json["tenors"]);
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": createdDate,
        // "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
        "productName": productName,
        "productCode": productCode,
        "productCategory": productCategory,
        "minTransactionLimit": minTransactionLimit,
        "maxTransactionLimit": maxTransactionLimit,
        "tenorDisplayIn": tenorDisplayIn,
        "status": status,
        "productDescription": productDescription,
        "imageUrl": imageUrl,
        "currency": currency!.toJson(),
        "properties": properties!.toJson(),
        "tenors": tenors!.toJson(),
        "allowCustomization": allowCustomization,
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
    this.interestOption,
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
  InterestOption? interestOption;
  String? interestFormula;
  String? penaltyFormula;
  DateTime? createdDate;

  Properties.fromJson(Map<String, dynamic> json) {
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

    allowsDirectDebit = json["allowsDirectDebit"];
    paymentType = json["paymentType"];
    allowsMonthlyDraw = json["allowsMonthlyDraw"];
    acceptsRollover = json["acceptsRollover"];
    allowsLiquidation = json["allowsLiquidation"];
    allowsTransfer = json["allowsTransfer"];
    receivesTransfer = json["receivesTransfer"];
    allowsTopUp = json["allowsTopUp"];
    tenorInDays = json["tenorInDays"];
    tenorInYears = json["tenorInYears"];

    interestOption = InterestOption.fromJson(json["interestOptions"]);

    interestFormula = json["interestFormula"];
    penaltyFormula = json["penaltyFormula"];
    createdDate = DateTime.parse(json["createdDate"]);
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
        "interestOption": interestOption!.toJson(),
        "interestFormula": interestFormula,
        "penaltyFormula": penaltyFormula,
        "createdDate":
            "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
      };
}

class InterestOption {
  InterestOption({
    this.id,
    this.hasUpfrontInterestRate,
    this.hasMonthlyInterestRate,
    this.hasQuarterlyInterestRate,
    this.hasBiAnnualInterestRate,
    this.hasMaturityInterestRate,
    this.hasBackendUpfrontInterestRate,
    this.hasBackendMonthlyInterestRate,
    this.hasBackendQuarterlyInterestRate,
    this.hasBackendBiAnnualInterestRate,
    this.hasBackendMaturityRate,
    this.hasMaturityRate,
  });

  int? id;
  bool? hasUpfrontInterestRate;
  bool? hasMonthlyInterestRate;
  bool? hasQuarterlyInterestRate;
  bool? hasBiAnnualInterestRate;
  bool? hasMaturityInterestRate;
  bool? hasBackendUpfrontInterestRate;
  bool? hasBackendMonthlyInterestRate;
  bool? hasBackendQuarterlyInterestRate;
  bool? hasBackendBiAnnualInterestRate;
  bool? hasBackendMaturityRate;
  bool? hasMaturityRate;

  factory InterestOption.fromJson(Map<String, dynamic> json) => InterestOption(
        id: json["id"],
        hasUpfrontInterestRate: json["hasUpfrontInterestRate"],
        hasMonthlyInterestRate: json["hasMonthlyInterestRate"],
        hasQuarterlyInterestRate: json["hasQuarterlyInterestRate"],
        hasBiAnnualInterestRate: json["hasBiAnnualInterestRate"],
        hasMaturityInterestRate: json["hasMaturityInterestRate"],
        hasBackendUpfrontInterestRate: json["hasBackendUpfrontInterestRate"],
        hasBackendMonthlyInterestRate: json["hasBackendMonthlyInterestRate"],
        hasBackendQuarterlyInterestRate:
            json["hasBackendQuarterlyInterestRate"],
        hasBackendBiAnnualInterestRate: json["hasBackendBiAnnualInterestRate"],
        hasBackendMaturityRate: json["hasBackendMaturityRate"],
        hasMaturityRate: json["hasMaturityRate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "hasUpfrontInterestRate": hasUpfrontInterestRate,
        "hasMonthlyInterestRate": hasMonthlyInterestRate,
        "hasQuarterlyInterestRate": hasQuarterlyInterestRate,
        "hasBiAnnualInterestRate": hasBiAnnualInterestRate,
        "hasMaturityInterestRate": hasMaturityInterestRate,
        "hasBackendUpfrontInterestRate": hasBackendUpfrontInterestRate,
        "hasBackendMonthlyInterestRate": hasBackendMonthlyInterestRate,
        "hasBackendQuarterlyInterestRate": hasBackendQuarterlyInterestRate,
        "hasBackendBiAnnualInterestRate": hasBackendBiAnnualInterestRate,
        "hasBackendMaturityRate": hasBackendMaturityRate,
        "hasMaturityRate": hasMaturityRate,
      };
}

class Currency {
  Currency({
    this.id,
    this.name,
    this.status,
    this.dateAdded,
  });

  int? id;
  String? name;
  String? status;
  DateTime? dateAdded;

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        dateAdded: DateTime.parse(json["dateAdded"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "dateAdded":
            "${dateAdded!.year.toString().padLeft(4, '0')}-${dateAdded!.month.toString().padLeft(2, '0')}-${dateAdded!.day.toString().padLeft(2, '0')}",
      };
}

class Tenor {
  Tenor({
    this.id,
    this.tenorName,
    this.tenorDescription,
    this.tenorDisplayIn,
    this.tenorDays,
    this.tenorWeeks,
    this.tenorMonths,
    this.tenorYears,
    this.tenorStatus,
    this.allowCustomization,
    this.createdDate,
  });

  int? id;
  String? tenorName;
  String? tenorDescription;
  String? tenorDisplayIn;
  int? tenorDays;
  int? tenorWeeks;
  int? tenorMonths;
  int? tenorYears;
  String? tenorStatus;
  bool? allowCustomization;
  DateTime? createdDate;

  factory Tenor.fromJson(Map<String, dynamic> json) => Tenor(
      id: json["id"],
      tenorName: json["tenorName"],
      tenorDescription: json["tenorDescription"],
      tenorDisplayIn: json["tenorDisplayIn"],
      tenorDays: json["tenorDays"],
      tenorWeeks: json["tenorWeeks"],
      tenorMonths: json["tenorMonths"],
      tenorYears: json["tenorYears"],
      tenorStatus: json["tenorStatus"],
      allowCustomization: json["allowCustomization"],
      createdDate: DateTime.parse(json["createdDate"]));

  Map<String, dynamic> toJson() => {
        "id": id,
        "tenorName": tenorName,
        "tenorDescription": tenorDescription,
        "tenorDisplayIn": tenorDisplayIn,
        "tenorDays": tenorDays,
        "tenorWeeks": tenorWeeks,
        "tenorMonths": tenorMonths,
        "tenorYears": tenorYears,
        "tenorStatus": tenorStatus,
        "allowCustomization": allowCustomization,
        "createdDate":
            "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
      };
}
