// // To parse this JSON data, do
// //
// //     final currencyResponse = currencyResponseFromJson(jsonString);

// import 'dart:convert';

// import 'package:rosabon/model/response_models/base_response.dart';

// CurrencyResponse currencyResponseFromJson(String str) =>
//     CurrencyResponse.fromJson(json.decode(str));

// String currencyResponseToJson(CurrencyResponse data) =>
//     json.encode(data.toJson());

// class CurrencyResponse extends BaseResponse {
//   CurrencyResponse({this.body, message, baseStatus})
//       : super(baseStatus: baseStatus, message: message);

//   List<Currency>? body;

//   factory CurrencyResponse.fromJson(
//           Map<String, dynamic> json) =>
//       CurrencyResponse(
//           body: List<Currency>.from(
//               json["body"].map((x) => Currency.fromJson(x))),
//           baseStatus: json["baseStatus"] ?? true,
//           message: json["message"] ?? '');

//   Map<String, dynamic> toJson() => {
//         "body": List<dynamic>.from(body!.map((x) => x.toJson())),
//         "message": message,
//         "baseStatus": baseStatus,
//       };
// }

// class Currency {
//   Currency({
//     this.id,
//     this.name,
//     this.status,
//     this.dateAdded,
//   });

//   int? id;
//   String? name;
//   String? status;
//   DateTime? dateAdded;

//   factory Currency.fromJson(Map<String, dynamic> json) => Currency(
//         id: json["id"],
//         name: json["name"],
//         status: json["status"],
//         dateAdded: DateTime.parse(json["dateAdded"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "status": status,
//         "dateAdded":
//             "${dateAdded!.year.toString().padLeft(4, '0')}-${dateAdded!.month.toString().padLeft(2, '0')}-${dateAdded!.day.toString().padLeft(2, '0')}",
//       };
// }
