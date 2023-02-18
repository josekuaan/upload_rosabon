// To parse this JSON data, do
//
//     final penalResponse = penalResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

PenalResponse penalResponseFromJson(String str) =>
    PenalResponse.fromJson(json.decode(str));

String penalResponseToJson(PenalResponse data) => json.encode(data.toJson());

class PenalResponse extends BaseResponse {
  PenalResponse({this.penal, message, baseStatus})
      : super(baseStatus: baseStatus, message: message);

  List<Penal>? penal;

  factory PenalResponse.fromJson(Map<String, dynamic> json) => PenalResponse(
      penal: List<Penal>.from(json["penal"].map((x) => Penal.fromJson(x))),
      baseStatus: json["baseStatus"] ?? true,
      message: json["message"] ?? '');

  Map<String, dynamic> toJson() => {
        "penal": List<dynamic>.from(penal!.map((x) => x.toJson())),
        "message": message,
        "baseStatus": baseStatus,
      };
}

class Penal {
  Penal({
    this.id,
    this.dateAdded,
    this.product,
    this.minDaysElapsed,
    this.maxDaysElapsed,
    this.penalRate,
  });

  int? id;
  DateTime? dateAdded;
  Product? product;
  int? minDaysElapsed;
  int? maxDaysElapsed;
  double? penalRate;

  Penal.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    if (json["dateAdded"] != null) {
      dateAdded = DateTime.parse(json["dateAdded"]);
    }
    if (json["product"] != null) {
      product = Product.fromJson(json["product"]);
    }
    if (json["minDaysElapsed"] != null) {
      minDaysElapsed = json["minDaysElapsed"];
    }
    if (json["maxDaysElapsed"] != null) {
      maxDaysElapsed = json["maxDaysElapsed"];
    }
    if (json["penalRate"] != null) {
      penalRate = json["penalRate"];
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "dateAdded":
            "${dateAdded!.year.toString().padLeft(4, '0')}-${dateAdded!.month.toString().padLeft(2, '0')}-${dateAdded!.day.toString().padLeft(2, '0')}",
        "product": product!.toJson(),
        "minDaysElapsed": minDaysElapsed,
        "maxDaysElapsed": maxDaysElapsed,
        "penalRate": penalRate,
      };
}

class Product {
  Product({
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
  dynamic? tenorDisplayIn;
  String? status;
  String? productDescription;
  String? imageUrl;
  dynamic? currency;
  dynamic? properties;
  dynamic? tenors;
  bool? allowCustomization;

  Product.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    if (json["productName"] != null) {
      productName = json["productName"];
    }
    if (json["tenorDisplayIn"] != null) {
      tenorDisplayIn = json["tenorDisplayIn"];
    }
    if (json["maxTransactionLimit"] != null) {
      maxTransactionLimit = json["maxTransactionLimit"];
    }
    if (json["minTransactionLimit"] != null) {
      minTransactionLimit = json["minTransactionLimit"];
    }
    if (json["productCategory"] != null) {
      productCategory = json["productCategory"];
    }
    if (json["productCode"] != null) {
      productCode = json["productCode"];
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
      properties = json["properties"];
    }
    if (json["currency"] != null) {
      currency = json["currency"];
    }
    if (json["tenors"] != null) {
      tenors = json["tenors"];
    }
    if (json["allowCustomization"] != null) {
      allowCustomization = json["allowCustomization"];
    }
    createdDate = json["createdDate"] != null
        ? DateTime.parse(json["createdDate"])
        : null;
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
        "currency": currency,
        "properties": properties,
        "tenors": tenors,
        "allowCustomization": allowCustomization,
      };
}
