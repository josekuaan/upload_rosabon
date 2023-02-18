// To parse this JSON data, do
//
//     final productResponse = productResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

ProductCategoryResponse productCategoryResponseFromJson(String str) =>
    ProductCategoryResponse.fromJson(json.decode(str));

String productCategoryResponseToJson(ProductCategoryResponse data) =>
    json.encode(data.toJson());

class ProductCategoryResponse extends BaseResponse {
  ProductCategoryResponse({this.product, message, baseStatus})
      : super(baseStatus: baseStatus, message: message);

  List<Product>? product;

  factory ProductCategoryResponse.fromJson(Map<String, dynamic> json) =>
      ProductCategoryResponse(
          product: List<Product>.from(
              json["Product"].map((x) => Product.fromJson(x))),
          message: json["message"] ?? "",
          baseStatus: json["baseStatus"] ?? true);

  Map<String, dynamic> toJson() => {
        "Product": List<dynamic>.from(product!.map((x) => x.toJson())),
        "message": message,
        "baseStatus": baseStatus,
      };
}

class Product {
  Product({
    this.productCategoryId,
    this.productCategoryName,
    this.products,
  });

  int? productCategoryId;
  String? productCategoryName;
  List<Products>? products;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productCategoryId: json["productCategoryId"],
        productCategoryName: json["productCategoryName"],
        products: List<Products>.from(
            json["products"].map((x) => Products.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "productCategoryId": productCategoryId,
        "productCategoryName": productCategoryName,
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class Products {
  Products({
    this.id,
    this.actualMaturityDate,
    this.createdDate,
    this.productName,
    this.productCode,
    this.productCategoryId,
    this.minTransactionLimit,
    this.maxTransactionLimit,
    this.tenorDisplayIn,
    this.status,
    // this.interestOption,
    this.productDescription,
    this.allowCustomization,
    this.imageUrl,
    this.tenorId,
    this.currency,
    this.properties,
    this.tenors,
  });

  int? id;
  DateTime? actualMaturityDate;
  DateTime? createdDate;
  String? productName;
  String? productCode;
  int? productCategoryId;
  double? minTransactionLimit;
  double? maxTransactionLimit;
  bool? allowCustomization;
  String? tenorDisplayIn;
  String? status;
  // String? interestOption;
  String? productDescription;
  String? imageUrl;
  int? tenorId;
  List<Currency>? currency;
  Properties? properties;
  List<Tenor>? tenors;

  Products.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    if (json["actualMaturityDate"] != null) {
      actualMaturityDate = DateTime.parse(json["actualMaturityDate"]);
    }

    createdDate = json["createdDate"] != null
        ? DateTime.parse(json["createdDate"])
        : null;

    if (json["tenorDisplayIn"] != null) {
      tenorDisplayIn = json["tenorDisplayIn"];
    }
    if (json["productCode"] != null) {
      productCode = json["productCode"];
    }
    if (json["productName"] != null) {
      productName = json["productName"];
    }
    if (json["productCategoryId"] != null) {
      productCategoryId = json["productCategoryId"];
    }

    if (json["minTransactionLimit"] != null) {
      minTransactionLimit = json["minTransactionLimit"];
    }
    if (json["maxTransactionLimit"] != null) {
      maxTransactionLimit = json["maxTransactionLimit"];
    }
    if (json["allowCustomization"] != null) {
      allowCustomization = json["allowCustomization"];
    }
    if (json["status"] != null) {
      status = json["status"];
    }

    // if (json["interestOption"] != null) {
    //   interestOption = json["interestOption"];
    // }
    if (json["imageUrl"] != null) {
      imageUrl = json["imageUrl"];
    }
    if (json["productDescription"] != null) {
      productDescription = json["productDescription"];
    }
    if (json["tenorId"] != null) {
      tenorId = json["tenorId"];
    }

    currency = json["currency"] != null
        ? List<Currency>.from(json["currency"].map((x) => Currency.fromJson(x)))
        : null;

    properties = json["properties"] != null
        ? Properties.fromJson(json["properties"])
        : null;

    if (json["tenors"] != null) {
      tenors = List<Tenor>.from(json["tenors"].map((x) => Tenor.fromJson(x)));
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "actualMaturityDate":
            "${actualMaturityDate!.year.toString().padLeft(4, '0')}-${actualMaturityDate!.month.toString().padLeft(2, '0')}-${actualMaturityDate!.day.toString().padLeft(2, '0')}",
        "createdDate":
            "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
        "productName": productName,
        "productCode": productCode,
        "productCategoryId": productCategoryId,
        "minTransactionLimit": minTransactionLimit,
        "maxTransactionLimit": maxTransactionLimit,
        "allowCustomization": allowCustomization,
        "tenorDisplayIn": tenorDisplayIn,
        "status": status,
        // "interestOption": interestOption,
        "productDescription": productDescription,
        "imageUrl": imageUrl,
        "tenorId": tenorId,
        "currency": List<dynamic>.from(currency!.map((x) => x.toJson())),
        "properties": properties!.toJson(),
        "tenors": List<dynamic>.from(tenors!.map((x) => x.toJson())),
      };
}

class Tenor {
  Tenor({
    this.id,
    this.tenorName,
    this.tenorDescription,
    this.tenorDays,
    this.tenorMonths,
    this.tenorWeeks,
    this.tenorYears,
    this.tenorStatus,
    this.createdDate,
  });

  int? id;
  String? tenorName;
  dynamic? tenorDescription;
  int? tenorDays;
  int? tenorMonths;
  int? tenorWeeks;
  int? tenorYears;
  String? tenorStatus;
  DateTime? createdDate;

  factory Tenor.fromJson(Map<String, dynamic> json) => Tenor(
        id: json["id"],
        tenorName: json["tenorName"],
        tenorDescription: json["tenorDescription"],
        tenorDays: json["tenorDays"],
        tenorMonths: json["tenorMonths"],
        tenorWeeks: json["tenorWeeks"],
        tenorYears: json["tenorYears"],
        tenorStatus: json["tenorStatus"],
        createdDate: DateTime.parse(json["createdDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tenorName": tenorName,
        "tenorDescription": tenorDescription,
        "tenorDays": tenorDays,
        "tenorMonths": tenorMonths,
        "tenorWeeks": tenorWeeks,
        "tenorYears": tenorYears,
        "tenorStatus": tenorStatus,
        "createdDate":
            "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
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
        // dateAdded: DateTime.parse(json["dateAdded"]),
      );

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
    if (json["hasDirectDebit"] != null) {
      allowsDirectDebit = json["hasDirectDebit"];
    }
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
    if (json["receivesTransfer"] != null) {
      receivesTransfer = json["receivesTransfer"];
    }
    if (json["allowsTopUp"] != null) {
      allowsTopUp = json["allowsTopUp"];
    }
    if (json["tenorInDays"] != null) {
      tenorInDays = json["tenorInDays"];
    }
    if (json["tenorInYears"] != null) {
      receivesTransfer = json["tenorInYears"];
    }
    if (json["interestFormula"] != null) {
      interestFormula = json["interestFormula"];
    }
    if (json["penaltyFormula"] != null) {
      penaltyFormula = json["penaltyFormula"];
    }
    interestOption = json["interestOptions"] != null
        ? InterestOption.fromJson(json["interestOptions"])
        : null;

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
