// // To parse this JSON data, do
// //
// //     final tenorResponse = tenorResponseFromJson(jsonString);

// import 'dart:convert';

// import 'package:rosabon/model/response_models/base_response.dart';

// TenorResponse tenorResponseFromJson(String str) =>
//     TenorResponse.fromJson(json.decode(str));

// String tenorResponseToJson(TenorResponse data) => json.encode(data.toJson());

// class TenorResponse extends BaseResponse {
//   TenorResponse({this.body, message, baseStatus})
//       : super(baseStatus: baseStatus, message: message);

//   List<Tenor>? body;

//   factory TenorResponse.fromJson(Map<String, dynamic> json) => TenorResponse(
//       body: List<Tenor>.from(json["body"].map((x) => Tenor.fromJson(x))),
//       message: json["message"] ?? "",
//       baseStatus: json["baseStatus"] ?? true);

//   Map<String, dynamic> toJson() => {
//         "body": List<dynamic>.from(body!.map((x) => x.toJson())),
//         "message": message,
//         "baseStatus": baseStatus,
//       };
// }

// class Tenor {
//   Tenor({
//     this.id,
//     this.tenorName,
//     this.tenorDescription,
//     this.tenorDisplayIn,
//     this.tenorDays,
//     this.tenorWeeks,
//     this.tenorMonths,
//     this.tenorYears,
//     this.tenorStatus,
//     this.allowCustomization,
//     this.createdDate,
//   });

//   int? id;
//   String? tenorName;
//   String? tenorDescription;
//   String? tenorDisplayIn;
//   int? tenorDays;
//   int? tenorWeeks;
//   int? tenorMonths;
//   int? tenorYears;
//   String? tenorStatus;
//   bool? allowCustomization;
//   DateTime? createdDate;

//   factory Tenor.fromJson(Map<String, dynamic> json) => Tenor(
//       id: json["id"],
//       tenorName: json["tenorName"],
//       tenorDescription: json["tenorDescription"],
//       tenorDisplayIn: json["tenorDisplayIn"],
//       tenorDays: json["tenorDays"],
//       tenorWeeks: json["tenorWeeks"],
//       tenorMonths: json["tenorMonths"],
//       tenorYears: json["tenorYears"],
//       tenorStatus: json["tenorStatus"],
//       allowCustomization: json["allowCustomization"],
//       createdDate: DateTime.parse(json["createdDate"]));

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "tenorName": tenorName,
//         "tenorDescription": tenorDescription,
//         "tenorDisplayIn": tenorDisplayIn,
//         "tenorDays": tenorDays,
//         "tenorWeeks": tenorWeeks,
//         "tenorMonths": tenorMonths,
//         "tenorYears": tenorYears,
//         "tenorStatus": tenorStatus,
//         "allowCustomization": allowCustomization,
//         "createdDate":
//             "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
//       };
// }
