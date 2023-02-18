// To parse this JSON data, do
//
//     final productResponse = productResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

ProductResponse productResponseFromJson(String str) =>
    ProductResponse.fromJson(json.decode(str));

String productResponseToJson(ProductResponse items) =>
    json.encode(items.toJson());

class ProductResponse extends BaseResponse {
  ProductResponse({this.items, message, baseStatus})
      : super(baseStatus: baseStatus, message: message);

  List<Item>? items;

  ProductResponse.fromJson(Map<String, dynamic> json) {
    items = List<Item>.from(json["items"].map((x) => Item.fromJson(x)));
    message = json["message"] ?? "";
    baseStatus = json["baseStatus"] ?? true;
  }

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "message": message,
        "baseStatus": baseStatus,
      };
}

class Item extends BaseResponse {
  Item(
      {this.id,
      this.createdDate,
      this.productName,
      this.productCode,
      this.actualMaturityDate,
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
      message,
      baseStatus})
      : super(baseStatus: baseStatus, message: message);

  int? id;
  DateTime? createdDate;
  DateTime? actualMaturityDate;
  String? productName;
  String? productCode;
  ProductCategory? productCategory;
  double? minTransactionLimit;
  double? maxTransactionLimit;
  String? tenorDisplayIn;
  String? status;
  String? productDescription;
  String? imageUrl;
  List<Currency>? currency;
  Properties? properties;
  List<ProductTenor>? tenors;
  bool? allowCustomization;
  Item.fromJson(Map<String, dynamic> json) {
    if (json["id"] != null) {
      id = json["id"];
    }
    if (json["actualMaturityDate"] != null) {
      actualMaturityDate = DateTime.parse(json["actualMaturityDate"]);
    }

    createdDate = json["createdDate"] != null
        ? DateTime.parse(json["createdDate"])
        : null;
    if (json["productCode"] != null) {
      productCode = json["productCode"];
    }
    if (json["productName"] != null) {
      productName = json["productName"];
    }
    productCategory = json["productCategory"] != null
        ? ProductCategory.fromJson(json["productCategory"])
        : null;
    //  productCategoryId = json["productCategoryId"];
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
    if (json["imageUrl"] != null) {
      imageUrl = json["imageUrl"];
    }
    if (json["productDescription"] != null) {
      productDescription = json["productDescription"];
    }
    currency = json["currency"] != null
        ? List<Currency>.from(json["currency"].map((x) => Currency.fromJson(x)))
        : null;

    properties = json["properties"] != null
        ? Properties.fromJson(json["properties"])
        : null;

    if (json["tenors"] != null) {
      tenors = List<ProductTenor>.from(
          json["tenors"].map((x) => ProductTenor.fromJson(x)));
    }

    if (json["allowCustomization"] != null) {
      allowCustomization = json["allowCustomization"];
    }
    message = json["message"] ?? "";
    baseStatus = json["baseStatus"] ?? true;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate":
            "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
        "productName": productName,
        "productCode": productCode,
        "productCategory": productCategory!.toJson(),
        "minTransactionLimit": minTransactionLimit,
        "maxTransactionLimit": maxTransactionLimit,
        "tenorDisplayIn": tenorDisplayIn,
        "status": status,
        "productDescription": productDescription,
        "imageUrl": imageUrl,
        "currency": List<dynamic>.from(currency!.map((x) => x.toJson())),
        "properties": properties!.toJson(),
        "tenors": List<dynamic>.from(tenors!.map((x) => x.toJson())),
        "allowCustomization": allowCustomization,
        "message": message,
        "baseStatus": baseStatus,
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

  Currency.fromJson(Map<String, dynamic> json) {
    if (json["id"] != null) {
      id = json["id"];
    }
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

class ProductTenor {
  ProductTenor({
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
  String? tenorDescription;
  int? tenorDays;
  int? tenorMonths;
  int? tenorWeeks;
  int? tenorYears;
  String? tenorStatus;
  DateTime? createdDate;

  ProductTenor.fromJson(Map<String, dynamic> json) {
    if (json["id"] != null) {
      id = json["id"];
    }
    if (json["tenorName"] != null) {
      tenorName = json["tenorName"];
    }
    if (json["tenorDescription"] != null) {
      tenorDescription = json["tenorDescription"];
    }
    if (json["tenorDays"] != null) {
      tenorDays = json["tenorDays"];
    }
    if (json["tenorMonths"] != null) {
      tenorMonths = json["tenorMonths"];
    }
    if (json["tenorWeeks"] != null) {
      tenorWeeks = json["tenorWeeks"];
    }
    if (json["tenorYears"] != null) {
      tenorYears = json["tenorYears"];
    }
    if (json["tenorStatus"] != null) {
      tenorStatus = json["tenorStatus"];
    }
    if (json["createdDate"] != null) {
      createdDate = DateTime.parse(json["createdDate"]);
    }
  }

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
    if (json["id"] != null) {
      id = json["id"];
    }
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

  @override
  String toString() {
    return " id: $id,hasTargetAmount: $hasTargetAmount,hasContributionValue: $hasContributionValue,hasSavingFrequency: $hasSavingFrequency,allowsDirectDebit: $allowsDirectDebit,paymentType: $paymentType,allowsMonthlyDraw: $allowsMonthlyDraw,acceptsRollover: $acceptsRollover,allowsLiquidation: $allowsLiquidation,allowsTransfer: $allowsTransfer,receivesTransfer: $receivesTransfer,allowsTopUp: $allowsTopUp,tenorInDays: $tenorInDays,tenorInYears: $tenorInYears,interestOption: $interestOption,interestFormula: $interestFormula,penaltyFormula: $penaltyFormula,createdDate: $createdDate";
  }
}

class InterestOption {
  InterestOption({
    this.hasUpfrontInterestRate,
    this.hasMonthlyInterestRate,
    this.hasQuarterlyInterestRate,
    this.hasBiAnnualInterestRate,
    this.hasMaturityInterestRate,
    this.hasBackendUpfrontInterestRate,
    this.hasBackendMonthlyInterestRate,
    this.hasBackendQuarterlyInterestRate,
    this.hasBackendBiAnnualInterestRate,
    this.hasBackendMaturityInterestRate,
  });

  bool? hasUpfrontInterestRate;
  bool? hasMonthlyInterestRate;
  bool? hasQuarterlyInterestRate;
  bool? hasBiAnnualInterestRate;
  bool? hasMaturityInterestRate;
  bool? hasBackendUpfrontInterestRate;
  bool? hasBackendMonthlyInterestRate;
  bool? hasBackendQuarterlyInterestRate;
  bool? hasBackendBiAnnualInterestRate;
  bool? hasBackendMaturityInterestRate;

  InterestOption.fromJson(Map<String, dynamic> json) {
    if (json["hasUpfrontInterestRate"] != null) {
      hasUpfrontInterestRate = json["hasUpfrontInterestRate"];
    }
    if (json["hasMonthlyInterestRate"] != null) {
      hasMonthlyInterestRate = json["hasMonthlyInterestRate"];
    }
    if (json["hasQuarterlyInterestRate"] != null) {
      hasQuarterlyInterestRate = json["hasQuarterlyInterestRate"];
    }
    if (json["hasBiAnnualInterestRate"] != null) {
      hasBiAnnualInterestRate = json["hasBiAnnualInterestRate"];
    }
    if (json["hasMaturityInterestRate"] != null) {
      hasMaturityInterestRate = json["hasMaturityInterestRate"];
    }
    if (json["hasBackendUpfrontInterestRate"] != null) {
      hasBackendUpfrontInterestRate = json["hasBackendUpfrontInterestRate"];
    }
    if (json["hasBackendMonthlyInterestRate"] != null) {
      hasBackendMonthlyInterestRate = json["hasBackendMonthlyInterestRate"];
    }
    if (json["hasBackendQuarterlyInterestRate"] != null) {
      hasBackendQuarterlyInterestRate = json["hasBackendQuarterlyInterestRate"];
    }
    if (json["hasBackendBiAnnualInterestRate"] != null) {
      hasBackendBiAnnualInterestRate = json["hasBackendBiAnnualInterestRate"];
    }
    if (json["hasBackendMaturityInterestRate"] != null) {
      hasBackendMaturityInterestRate = json["hasBackendMaturityInterestRate"];
    }
  }

  Map<String, dynamic> toJson() => {
        "hasUpfrontInterestRate": hasUpfrontInterestRate,
        "hasMonthlyInterestRate": hasMonthlyInterestRate,
        "hasQuarterlyInterestRate": hasQuarterlyInterestRate,
        "hasBiAnnualInterestRate": hasBiAnnualInterestRate,
        "hasMaturityInterestRate": hasMaturityInterestRate,
        "hasBackendUpfrontInterestRate": hasBackendUpfrontInterestRate,
        "hasBackendMonthlyInterestRate": hasBackendMonthlyInterestRate,
        "hasBackendQuarterlyInterestRate": hasBackendQuarterlyInterestRate,
        "hasBackendBiAnnualInterestRate": hasBackendBiAnnualInterestRate,
        "hasBackendMaturityInterestRate": hasBackendMaturityInterestRate,
      };
}

class ProductCategory {
  ProductCategory({
    this.id,
    this.createdDate,
    this.description,
    this.name,
    this.status,
  });

  int? id;
  DateTime? createdDate;
  String? description;
  String? name;
  String? status;

  ProductCategory.fromJson(Map<String, dynamic> json) {
    if (json["id"] != null) {
      id = json["id"];
    }
    if (json["name"] != null) {
      name = json["name"];
    }
    if (json["description"] != null) {
      description = json["description"];
    }
    if (json["status"] != null) {
      status = json["status"];
    }
    if (json["createdDate"] != null) {
      createdDate = DateTime.parse(json["createdDate"]);
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate":
            "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
        "description": description,
        "name": name,
        "status": status,
      };
}
