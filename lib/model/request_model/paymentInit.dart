// To parse this JSON data, do
//
//     final paymentInit = paymentInitFromJson(jsonString);

import 'dart:convert';

PaymentInit paymentInitFromJson(String str) =>
    PaymentInit.fromJson(json.decode(str));

String paymentInitToJson(PaymentInit data) => json.encode(data.toJson());

class PaymentInit {
  PaymentInit({
    this.amount,
    this.purposeOfPayment,
    this.email,
    this.refund,
  });

  String? amount;
  String? purposeOfPayment;
  bool? refund;
  String? email;

  factory PaymentInit.fromJson(Map<String, dynamic> json) => PaymentInit(
      amount: json["amount"],
      purposeOfPayment: json["purposeOfPayment"],
      email: json["email"],
      refund: json["refund"]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (amount != null) {
      data["amount"] = amount;
    }
    if (email != null) {
      data["email"] = email;
    }
    if (refund != null) {
      data["refund"] = refund;
    }
    if (purposeOfPayment != null) {
      data["purposeOfPayment"] = purposeOfPayment;
    }

    return data;
  }
}
