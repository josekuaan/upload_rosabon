// To parse this JSON data, do
//
//     final planRequest = planRequestFromJson(jsonString);

import 'dart:convert';

PlanRequest planRequestFromJson(String str) =>
    PlanRequest.fromJson(json.decode(str));

String planRequestToJson(PlanRequest data) => json.encode(data.toJson());

class PlanRequest {
  PlanRequest({
    this.allowsLiquidation,
    this.amount,
    this.autoRenew,
    this.contributionValue,
    this.currency,
    this.dateCreated,
    this.directDebit,
    this.exchangeRate,
    this.planStatus,
    this.nameOfDirectDebitCard,
    this.interestRate,
    this.interestReceiptOption,
    this.monthlyContributionDay,
    this.numberOfTickets,
    this.paymentMethod,
    this.bankAccountInfo,
    this.planDate,
    this.planName,
    this.planSummary,
    this.actualMaturityDate,
    this.product,
    this.acceptPeriodicContribution,
    this.autoRollover,
    this.productCategory,
    this.savingFrequency,
    this.targetAmount,
    this.tenor,
    // this.paymentMaturity,
    this.weeklyContributionDay,
  });

  bool? allowsLiquidation;
  int? amount;
  bool? autoRenew;
  double? contributionValue;
  int? currency;
  DateTime? dateCreated;
  bool? directDebit;
  double? exchangeRate;
  String? nameOfDirectDebitCard;
  double? interestRate;
  String? interestReceiptOption;
  String? planStatus;
  // int? interestReceiptOption;
  int? monthlyContributionDay;
  int? numberOfTickets;
  bool? acceptPeriodicContribution;
  bool? autoRollover;
  String? paymentMethod;
  BankAccountInfo? bankAccountInfo;
  DateTime? planDate;
  String? actualMaturityDate;
  String? planName;
  PlanSummary? planSummary;
  int? product;
  int? productCategory;
  // int? paymentMaturity;
  String? savingFrequency;
  int? targetAmount;
  int? tenor;
  String? weeklyContributionDay;

  PlanRequest.fromJson(Map<String, dynamic> json) {
    allowsLiquidation = json["allowsLiquidation"];
    amount = json["amount"];
    autoRenew = json["autoRenew"];
    planStatus = json["planStatus"];
    if (json["contributionValue"] != null) {
      contributionValue = json["contributionValue"];
    }
    acceptPeriodicContribution = json["acceptPeriodicContribution"];
    if (json["actualMaturityDate"] != null) {
      actualMaturityDate = json["actualMaturityDate"];
    }
    currency = json["currency"];
    dateCreated = DateTime.parse(json["dateCreated"]);
    directDebit = json["directDebit"];
    if (json["exchangeRate"]) {
      exchangeRate = json["exchangeRate"];
    }
    if (json["nameOfDirectDebitCard"]) {
      nameOfDirectDebitCard = json["nameOfDirectDebitCard"];
    }
    if (json["interestRate"] != null) {
      interestRate = json["interestRate"];
    }

    interestReceiptOption = json["interestReceiptOption"];
    monthlyContributionDay = json["monthlyContributionDay"];
    if (json["numberOfTickets"] != null) {
      numberOfTickets = json["numberOfTickets"];
    }
    if (json["paymentMethod"] != null) {
      paymentMethod = json["paymentMethod"];
    }
    // paymentType = json["paymentType"];
    planDate = DateTime.parse(json["planDate"]);
    planName = json["planName"];
    if (json["planSummary"] != null) {
      planSummary = PlanSummary.fromJson(json["planSummary"]);
    }
    if (json["product"] != null) {
      product = json["product"];
    }
    if (json["bankAccountInfo"] != null) {
      bankAccountInfo = BankAccountInfo.fromJson(json["bankAccountInfo"]);
    }
    productCategory = json["productCategory"];
    autoRollover = json["autoRollover"];
    if (json["savingFrequency"] != null) {
      savingFrequency = json["savingFrequency"];
    }
    if (json["targetAmount"] != null) {
      targetAmount = json["targetAmount"];
    }
    if (json["tenorId"]) {
      tenor = json["tenor"];
    }
    if (json["weeklyContributionDay"] != null) {
      weeklyContributionDay = json["weeklyContributionDay"];
    }
  }

  Map<String, dynamic> toJson() => {
        "allowsLiquidation": allowsLiquidation,
        "amount": amount ?? null,
        "planStatus": planStatus,
        "autoRenew": autoRenew,
        "autoRollover": autoRollover,
        "contributionValue": contributionValue ?? null,
        "currency": currency,
        "dateCreated":
            "${dateCreated!.year.toString().padLeft(4, '0')}-${dateCreated!.month.toString().padLeft(2, '0')}-${dateCreated!.day.toString().padLeft(2, '0')}"
                .toString(),
        "actualMaturityDate": actualMaturityDate,

        "directDebit": directDebit,
        "exchangeRate": exchangeRate ?? null,
        "nameOfDirectDebitCard": nameOfDirectDebitCard ?? null,
        "interestRate": interestRate ?? null,
        "interestReceiptOption": interestReceiptOption,
        "monthlyContributionDay": monthlyContributionDay ?? null,
        "numberOfTickets": numberOfTickets ?? null,
        "paymentMethod": paymentMethod ?? null,
        "bankAccountInfo":
            bankAccountInfo == null ? null : bankAccountInfo!.toJson(),
        "planDate":
            "${planDate!.year.toString().padLeft(4, '0')}-${planDate!.month.toString().padLeft(2, '0')}-${planDate!.day.toString().padLeft(2, '0')}"
                as String,
        "planName": planName,
        "planSummary": planSummary == null ? null : planSummary!.toJson(),
        "product": product,
        "productCategory": productCategory,
        "savingFrequency": savingFrequency ?? null,
        "targetAmount": targetAmount ?? null,
        "tenor": tenor ?? null,
        "weeklyContributionDay": weeklyContributionDay ?? null,
        "acceptPeriodicContribution": acceptPeriodicContribution,
        // "actualMaturityDate": actualMaturityDate,
        // "paymentMaturity": paymentMaturity,
      };
}

class BankAccountInfo {
  BankAccountInfo({
    this.accountName,
    this.accountNumber,
    this.bankName,
  });

  String? accountName;
  String? accountNumber;
  String? bankName;

  factory BankAccountInfo.fromJson(Map<String, dynamic> json) =>
      BankAccountInfo(
        accountName: json["accountName"],
        accountNumber: json["accountNumber"],
        bankName: json["bankName"],
      );

  Map<String, dynamic> toJson() => {
        "accountName": accountName,
        "accountNumber": accountNumber,
        "bankName": bankName,
      };
}

class PlanSummary {
  PlanSummary({
    this.calculatedInterest,
    this.endDate,
    // this.interestPaymentFrequency,
    this.interestReceiptOption,
    this.interestRate,
    this.paymentMaturity,
    this.planName,
    this.principal,
    this.startDate,
    this.withholdingTax,
  });

  double? calculatedInterest;
  String? endDate;
  String? interestReceiptOption;
  // String? interestPaymentFrequency;
  double? interestRate;
  double? paymentMaturity;
  String? planName;
  int? principal;
  String? startDate;
  double? withholdingTax;

  factory PlanSummary.fromJson(Map<String, dynamic> json) => PlanSummary(
        calculatedInterest: json["calculatedInterest"],
        endDate: json["endDate"],
        // interestPaymentFrequency: json["interestPaymentFrequency"],
        interestReceiptOption: json["interestReceiptOption"],
        interestRate: json["interestRate"],
        paymentMaturity: json["paymentMaturity"],
        planName: json["planName"],
        principal: json["principal"],
        startDate: json["startDate"],
        withholdingTax: json["withholdingTax"],
      );

  Map<String, dynamic> toJson() => {
        "calculatedInterest": calculatedInterest,
        "endDate": endDate.toString(),
        "interestReceiptOption": interestReceiptOption,
        // "interestPaymentFrequency": interestPaymentFrequency,
        "interestRate": interestRate,
        "paymentMaturity": paymentMaturity,
        "planName": planName,
        "principal": principal,
        "startDate": startDate.toString(),
        "withholdingTax": withholdingTax,
      };
}
