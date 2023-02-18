// To parse this JSON data, do
//
//     final walletPlanTransferRequest = walletPlanTransferRequestFromJson(jsonString);

import 'dart:convert';

WalletPlanTransferRequest walletPlanTransferRequestFromJson(String str) => WalletPlanTransferRequest.fromJson(json.decode(str));

String walletPlanTransferRequestToJson(WalletPlanTransferRequest data) => json.encode(data.toJson());

class WalletPlanTransferRequest {
    WalletPlanTransferRequest({
        this.amount,
        this.description,
        this.planId,
    });

    int? amount;
    String? description;
    int? planId;

    factory WalletPlanTransferRequest.fromJson(Map<String, dynamic> json) => WalletPlanTransferRequest(
        amount: json["amount"],
        description: json["description"],
        planId: json["planId"],
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "description": description,
        "planId": planId,
    };
}
