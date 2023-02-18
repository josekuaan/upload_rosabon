// To parse this JSON data, do
//
//     final exchangeResponse = exchangeResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

ExchangeResponse exchangeResponseFromJson(String str) =>
    ExchangeResponse.fromJson(json.decode(str));

String exchangeResponseToJson(ExchangeResponse data) =>
    json.encode(data.toJson());

class ExchangeResponse extends BaseResponse {
  ExchangeResponse({this.exchange, message, baseStatus})
      : super(baseStatus: baseStatus, message: message);

  List<Exchange>? exchange;
  // Exchange? exchange;
  
  
  // var map = {};
  // exchange!.forEach((customer) => map[customer.sellingPrice] = customer.sellingPrice);


  factory ExchangeResponse.fromJson(Map<String, dynamic> json) {

    return
       ExchangeResponse(
        exchange:
            List<Exchange>.from(json['body'].map((x) => Exchange.fromJson(x))),
        // exchange: json["body"] != null ?
        //  Exchange.fromJson(json["body"]) : null,
        baseStatus: json["baseStatus"] ?? true,
        message: json["message"] ?? '',
      );
  }
  // =>
      // ExchangeResponse(
      //   exchange:
      //       List<Exchange>.from(json['body'].map((x) => Exchange.fromJson(x))),
      //   // exchange: json["body"] != null ?
      //   //  Exchange.fromJson(json["body"]) : null,
      //   baseStatus: json["baseStatus"] ?? true,
      //   message: json["message"] ?? '',
      // );

  Map<String, dynamic> toJson() => {
        "exchange": List<dynamic>.from(exchange!.map((x) => x.toJson())),
        // "exchange": exchange!.toJson(),
        "message": message,
        "baseStatus": baseStatus,
      };
}

class Exchange {
  Exchange({
    this.id,
    this.dateAdded,
    this.name,
    this.buyingPrice,
    this.sellingPrice,
    this.status,
  });

  int? id;
  DateTime? dateAdded;
  String? name;
  double? buyingPrice;
  double? sellingPrice;
  String? status;

  factory Exchange.fromJson(Map<String, dynamic> json) => Exchange(
        id: json["id"],
        dateAdded: DateTime.parse(json["dateAdded"]),
        name: json["name"],
        buyingPrice: json["buyingPrice"],
        sellingPrice: json["sellingPrice"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dateAdded":
            "${dateAdded!.year.toString().padLeft(4, '0')}-${dateAdded!.month.toString().padLeft(2, '0')}-${dateAdded!.day.toString().padLeft(2, '0')}",
        "name": name,
        "buyingPrice": buyingPrice,
        "sellingPrice": sellingPrice,
        "status": status,
      };
}
