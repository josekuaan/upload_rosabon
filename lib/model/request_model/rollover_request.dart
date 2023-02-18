// To parse this JSON data, do
//
//     final rolloverResquest = rolloverResquestFromJson(jsonString);

import 'dart:convert';

RolloverResquest rolloverResquestFromJson(String str) =>
    RolloverResquest.fromJson(json.decode(str));

String rolloverResquestToJson(RolloverResquest data) =>
    json.encode(data.toJson());

class RolloverResquest {
  RolloverResquest({
    this.amount,
    this.balanceAfterRollover,
    this.bankAccountDetails,
    this.completed,
    this.corporateUserWithdrawalMandate,
    this.plan,
    this.planAction,
    this.rollToPlan,
    this.withdrawTo,
  });

  int? amount;
  int? balanceAfterRollover;
  int? bankAccountDetails;
  bool? completed;
  dynamic? corporateUserWithdrawalMandate;
  int? plan;
  String? planAction;
  RollToPlan? rollToPlan;
  String? withdrawTo;

  factory RolloverResquest.fromJson(Map<String, dynamic> json) =>
      RolloverResquest(
        amount: json["amount"],
        balanceAfterRollover: json["balanceAfterRollover"],
        bankAccountDetails: json["bankAccountDetails"],
        completed: json["completed"],
        corporateUserWithdrawalMandate: json["corporateUserWithdrawalMandate"],
        plan: json["plan"],
        planAction: json["planAction"],
        rollToPlan: RollToPlan.fromJson(json["rollToPlan"]),
        withdrawTo: json["withdrawTo"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "balanceAfterRollover": balanceAfterRollover,
        "bankAccountDetails": bankAccountDetails,
        "completed": completed,
        "corporateUserWithdrawalMandate": corporateUserWithdrawalMandate,
        "plan": plan,
        "planAction": planAction,
        "rollToPlan": rollToPlan!.toJson(),
        "withdrawTo": withdrawTo,
      };
}

class RollToPlan {
  RollToPlan({
    this.acceptPeriodicContribution,
    this.actualMaturityDate,
    this.allowsLiquidation,
    this.amount,
    this.autoRenew,
    this.autoRollOver,
    this.bankAccountInfo,
    this.contributionValue,
    this.currency,
    this.dateCreated,
    this.directDebit,
    this.exchangeRate,
    this.interestRate,
    this.interestReceiptOption,
    this.monthlyContributionDay,
    this.numberOfTickets,
    this.paymentMethod,
    this.planDate,
    this.planName,
    this.planStatus,
    this.planSummary,
    this.product,
    this.productCategory,
    this.savingFrequency,
    this.targetAmount,
    this.tenor,
    this.weeklyContributionDay,
  });

  bool? acceptPeriodicContribution;
  DateTime? actualMaturityDate;
  bool? allowsLiquidation;
  dynamic? amount;
  bool? autoRenew;
  bool? autoRollOver;
  BankAccountInfo? bankAccountInfo;
  double? contributionValue;
  int? currency;
  DateTime? dateCreated;
  bool? directDebit;
  double? exchangeRate;
  double? interestRate;
  String? interestReceiptOption;
  int? monthlyContributionDay;
  int? numberOfTickets;
  String? paymentMethod;
  DateTime? planDate;
  String? planName;
  String? planStatus;
  PlanSummary? planSummary;
  int? product;
  int? productCategory;
  String? savingFrequency;
  double? targetAmount;
  int? tenor;
  dynamic? weeklyContributionDay;

  factory RollToPlan.fromJson(Map<String, dynamic> json) => RollToPlan(
        acceptPeriodicContribution: json["acceptPeriodicContribution"],
        actualMaturityDate: DateTime.parse(json["actualMaturityDate"]),
        allowsLiquidation: json["allowsLiquidation"],
        amount: json["amount"],
        autoRenew: json["autoRenew"],
        autoRollOver: json["autoRollOver"],
        contributionValue: json["contributionValue"],
        currency: json["currency"],
        dateCreated: DateTime.parse(json["dateCreated"]),
        directDebit: json["directDebit"],
        exchangeRate: json["exchangeRate"],
        interestRate: json["interestRate"],
        bankAccountInfo: BankAccountInfo.fromJson(json["bankAccountInfo"]),
        interestReceiptOption: json["interestReceiptOption"],
        monthlyContributionDay: json["monthlyContributionDay"],
        numberOfTickets: json["numberOfTickets"],
        paymentMethod: json["paymentMethod"],
        planDate: DateTime.parse(json["planDate"]),
        planName: json["planName"],
        planStatus: json["planStatus"],
        planSummary: PlanSummary.fromJson(json["planSummary"]),
        product: json["product"],
        productCategory: json["productCategory"],
        savingFrequency: json["savingFrequency"],
        targetAmount: json["targetAmount"],
        tenor: json["tenor"],
        weeklyContributionDay: json["weeklyContributionDay"],
      );

  Map<String, dynamic> toJson() => {
        "acceptPeriodicContribution": acceptPeriodicContribution,
        "actualMaturityDate":
            "${actualMaturityDate!.year.toString().padLeft(4, '0')}-${actualMaturityDate!.month.toString().padLeft(2, '0')}-${actualMaturityDate!.day.toString().padLeft(2, '0')}",
        "allowsLiquidation": allowsLiquidation,
        "amount": amount,
        "autoRenew": autoRenew,
        "autoRollOver": autoRollOver,
        "contributionValue": contributionValue,
        "currency": currency,
        "bankAccountInfo":
            bankAccountInfo != null ? bankAccountInfo!.toJson() : null,
        "dateCreated":
            "${dateCreated!.year.toString().padLeft(4, '0')}-${dateCreated!.month.toString().padLeft(2, '0')}-${dateCreated!.day.toString().padLeft(2, '0')}",
        "directDebit": directDebit,
        "exchangeRate": exchangeRate,
        "interestRate": interestRate,
        "interestReceiptOption": interestReceiptOption,
        "monthlyContributionDay": monthlyContributionDay,
        "numberOfTickets": numberOfTickets,
        "paymentMethod": paymentMethod,
        "planDate":
            "${planDate!.year.toString().padLeft(4, '0')}-${planDate!.month.toString().padLeft(2, '0')}-${planDate!.day.toString().padLeft(2, '0')}",
        "planName": planName,
        "planStatus": planStatus,
        "planSummary": planSummary!.toJson(),
        "product": product,
        "productCategory": productCategory,
        "savingFrequency": savingFrequency,
        "targetAmount": targetAmount,
        "tenor": tenor,
        "weeklyContributionDay": weeklyContributionDay,
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
    this.interestRate,
    this.interestReceiptOption,
    this.paymentMaturity,
    this.planName,
    this.principal,
    this.interestPaymentFrequency,
    this.startDate,
    this.withholdingTax,
  });

  double? calculatedInterest;
  DateTime? endDate;
  double? interestRate;
  String? interestReceiptOption;
  String? interestPaymentFrequency;
  double? paymentMaturity;
  String? planName;
  double? principal;
  DateTime? startDate;
  double? withholdingTax;

  factory PlanSummary.fromJson(Map<String, dynamic> json) => PlanSummary(
        calculatedInterest: json["calculatedInterest"].toDouble(),
        endDate: DateTime.parse(json["endDate"]),
        interestRate: json["interestRate"],
        interestReceiptOption: json["interestReceiptOption"],
        paymentMaturity: json["paymentMaturity"].toDouble(),
        interestPaymentFrequency: json["interestPaymentFrequency"],
        planName: json["planName"],
        principal: json["principal"],
        startDate: DateTime.parse(json["startDate"]),
        withholdingTax: json["withholdingTax"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "calculatedInterest": calculatedInterest,
        "endDate":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "interestRate": interestRate,
        "interestReceiptOption": interestReceiptOption,
        "paymentMaturity": paymentMaturity,
        "interestPaymentFrequency": interestPaymentFrequency,
        "planName": planName,
        "principal": principal,
        "startDate":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "withholdingTax": withholdingTax,
      };
}
