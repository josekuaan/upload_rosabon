// To parse this JSON data, do
//
//     final withdrawalRequest = withdrawalRequestFromJson(jsonString);

import 'dart:convert';

WithdrawalRequest withdrawalRequestFromJson(String str) =>
    WithdrawalRequest.fromJson(json.decode(str));

String withdrawalRequestToJson(WithdrawalRequest data) =>
    json.encode(data.toJson());

class WithdrawalRequest {
  WithdrawalRequest({
    this.bankAccountId,
    this.withdrawalAmount,
    this.withdrawalInstructionImage,
    this.withdrawalMandateLetterImage,
    this.withdrawalReasonId,
    this.withdrawalReasonOthers,
  });

  int? bankAccountId;
  int? withdrawalAmount;
  WithdrawalInstructionImage? withdrawalInstructionImage;
  WithdrawalMandateLetterImage? withdrawalMandateLetterImage;
  int? withdrawalReasonId;
  String? withdrawalReasonOthers;

  WithdrawalRequest.fromJson(Map<String, dynamic> json) {
    if (json["bankAccountId"] != null) {
      bankAccountId = json["bankAccountId"];
    }

    withdrawalAmount = json["withdrawalAmount"];
    withdrawalInstructionImage = json["withdrawalInstructionImage"] != null
        ? WithdrawalInstructionImage.fromJson(
            json["withdrawalInstructionImage"])
        : null;

    withdrawalMandateLetterImage = json["withdrawalMandateLetterImage"] != null
        ? WithdrawalMandateLetterImage.fromJson(
            json["withdrawalMandateLetterImage"])
        : null;
    if (json["withdrawalReasonId"] != null) {
      withdrawalReasonId = json["withdrawalReasonId"];
    }
    withdrawalReasonOthers = json["withdrawalReasonOthers"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (bankAccountId != null) {
      data['bankAccountId'] = bankAccountId;
    }
    data['withdrawalAmount'] = withdrawalAmount;
    if (withdrawalInstructionImage != null) {
      data['withdrawalInstructionImage'] = withdrawalInstructionImage!.toJson();
    }
    if (withdrawalMandateLetterImage != null) {
      data['withdrawalMandateLetterImage'] =
          withdrawalMandateLetterImage!.toJson();
    }
    if (withdrawalReasonId != null) {
      data['withdrawalReasonId'] = withdrawalReasonId;
    }
    if (withdrawalReasonOthers != null) {
      data['withdrawalReasonOthers'] = withdrawalReasonOthers;
    }

    return data;
  }
}

class WithdrawalInstructionImage {
  WithdrawalInstructionImage({
    this.encodedUpload,
    this.name,
  });

  String? encodedUpload;
  String? name;

  factory WithdrawalInstructionImage.fromJson(Map<String, dynamic> json) =>
      WithdrawalInstructionImage(
        encodedUpload: json["encodedUpload"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "encodedUpload": encodedUpload,
        "name": name,
      };
}

class WithdrawalMandateLetterImage {
  WithdrawalMandateLetterImage({
    this.encodedUpload,
    this.name,
  });

  String? encodedUpload;
  String? name;

  factory WithdrawalMandateLetterImage.fromJson(Map<String, dynamic> json) =>
      WithdrawalMandateLetterImage(
        encodedUpload: json["encodedUpload"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "encodedUpload": encodedUpload,
        "name": name,
      };
}
