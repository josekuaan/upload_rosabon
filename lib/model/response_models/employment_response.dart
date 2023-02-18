// To parse this JSON data, do
//
//     final employmentResponse = employmentResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

EmploymentResponse employmentResponseFromJson(String str) =>
    EmploymentResponse.fromJson(json.decode(str));

String employmentResponseToJson(EmploymentResponse data) =>
    json.encode(data.toJson());

class EmploymentResponse extends BaseResponse {
  EmploymentResponse(
      {this.id,
      this.firstName,
      this.middleName,
      this.lastName,
      this.dateOfBirth,
      this.gender,
      this.address,
      this.bvn,
      this.coutryOfResidence,
      this.state,
      this.lga,
      this.employmentDetail,
      this.nokDetail,
      this.businessType,
      this.bankAccountVerified,
      message,
      baseStatus})
      : super(baseStatus: baseStatus, message: message);

  int? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? dateOfBirth;
  Gender? gender;
  Address? address;
  String? bvn;
  CoutryOfResidence? coutryOfResidence;
  String? state;
  String? lga;
  EmploymentDetail? employmentDetail;
  NextOfKinRes? nokDetail;
  dynamic? businessType;
  bool? bankAccountVerified;

  EmploymentResponse.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    firstName = json["firstName"];
    middleName = json["middleName"];
    lastName = json["lastName"];
    dateOfBirth = json["dateOfBirth"];
    if (json["gender"] != null) {
      gender = Gender.fromJson(json['gender']);
    }
    address =
        json["address"] != null ? Address.fromJson(json["address"]) : null;

    bvn = json["bvn"];
    coutryOfResidence = json["coutryOfResidence"] != null
        ? CoutryOfResidence.fromJson(json["coutryOfResidence"])
        : null;
    if (json["state"] != null) {
      state = json["state"];
    }
    if (json["lga"] != null) {
      lga = json["lga"];
    }
    if (json["employmentDetail"] != null) {
      employmentDetail = EmploymentDetail.fromJson(json["employmentDetail"]);
    }

    if (json["nokDetail"] != null) {
      nokDetail = NextOfKinRes.fromJson(json["nokDetail"]);
    }
    if (json["businessType"] != null) {
      businessType = json["businessType"];
    }

    bankAccountVerified = json["bankAccountVerified"];
    message = json["message"] ?? "";
    baseStatus = json["baseStatus"] ?? false;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "dateOfBirth": dateOfBirth,
        "gender": gender,
        "address": address!.toJson(),
        "bvn": bvn,
        "coutryOfResidence": coutryOfResidence!.toJson(),
        "state": state,
        "lga": lga,
        "employmentDetail": employmentDetail!.toJson(),
        "nokDetail": nokDetail,
        "businessType": businessType,
        "bankAccountVerified": bankAccountVerified,
        "message": message,
        "baseStatus": baseStatus,
      };
}

class Gender {
  String? gender;
  String? description;
  String? status;
  int? id;
  Gender({
    this.description,
    this.gender,
    this.status,
    this.id,
  });
  factory Gender.fromJson(Map<String, dynamic> json) => Gender(
        gender: json["gender"],
        status: json["status"],
        description: json["description"],
        id: json["id"],
      );
}

class Address {
  Address({
    this.city,
    this.country,
    this.houseNoAddress,
    this.id,
    this.postCode,
    this.state,
  });

  String? city;
  String? country;
  String? houseNoAddress;
  int? id;
  String? postCode;
  String? state;

  Address.fromJson(Map<String, dynamic> json) {
    print(json);
    if (json["city"] != null) {
      city = json["city"];
    }
    if (json["country"] != null) {
      country = json["country"];
    }
    if (json["houseNoAddress"] != null) {
      houseNoAddress = json["houseNoAddress"];
    }
    if (json["id"] != null) {
      id = json["id"];
    }
    if (json["postCode"] != null) {
      postCode = json["postCode"];
    }
    if (json["state"] != null) {
      state = json["state"];
    }
  }

  Map<String, dynamic> toJson() => {
        "city": city,
        "country": country,
        "houseNoAddress": houseNoAddress,
        "id": id,
        "postCode": postCode,
        "state": state,
      };
}

class NextOfKinRes {
  NextOfKinRes({
    this.nokAddress,
    this.email,
    this.id,
    this.name,
    this.phone,
  });

  String? nokAddress;
  String? email;
  int? id;
  String? name;
  String? phone;

  NextOfKinRes.fromJson(Map<String, dynamic> json) {
    if (json["nokAddress"] != null) {
      nokAddress = json["nokAddress"];
    }

    email = json["email"];
    id = json["id"];
    name = json["name"];
    phone = json["phone"];
  }

  Map<String, dynamic> toJson() => {
        "nokAddress": nokAddress,
        "email": email,
        "id": id,
        "name": name,
        "phone": phone,
      };
}

class CoutryOfResidence {
  CoutryOfResidence({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory CoutryOfResidence.fromJson(Map<String, dynamic> json) =>
      CoutryOfResidence(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class EmploymentDetail {
  EmploymentDetail({
    this.id,
    this.occupation,
    this.employerName,
    this.employerAddress,
  });

  int? id;
  String? occupation;
  String? employerName;
  String? employerAddress;

  factory EmploymentDetail.fromJson(Map<String, dynamic> json) =>
      EmploymentDetail(
        id: json["id"],
        occupation: json["occupation"],
        employerName: json["employerName"],
        employerAddress: json["employerAddress"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "occupation": occupation,
        "employerName": employerName,
        "employerAddress": employerAddress,
      };
}
