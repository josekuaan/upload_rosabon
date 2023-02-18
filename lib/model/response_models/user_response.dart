// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse extends BaseResponse {
  UserResponse(
      {this.id,
      this.phone,
      this.email,
      this.status,
      this.role,
      this.usage,
      this.creationSource,
      this.source,
      this.sourceOthers,
      this.sourceNotInTheList,
      this.referralCode,
      this.referralLog,
      this.createdAt,
      this.individualUser,
      this.myReferralCode,
      this.referralLink,
      this.referralBonus,
      this.company,
      this.administrator,
      this.virtualAccountName,
      this.virtualAccountNo,
      this.userType,
      this.department,
      this.businessUnit,
      this.kyc,
      this.assited,
      this.newsLetters,
      baseStatus,
      message})
      : super(baseStatus: baseStatus, message: message);

  int? id;
  String? phone;
  String? email;
  String? status;
  String? role;
  String? usage;
  String? creationSource;
  String? source;
  SourceOthers? sourceOthers;
  String? sourceNotInTheList;
  String? referralCode;
  String? referralLog;
  String? createdAt;
  IndividualUser? individualUser;
  String? myReferralCode;
  String? referralLink;
  ReferralBonus? referralBonus;
  Company? company;
  String? administrator;
  String? virtualAccountName;
  String? virtualAccountNo;
  String? userType;
  String? department;
  dynamic? businessUnit;
  bool? kyc;
  bool? assited;
  bool? newsLetters;

  UserResponse.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    phone = json["phone"];
    email = json["email"];
    status = json["status"];
    role = json["role"];
    if (json["creationSource"] != null) {
      creationSource = json["creationSource"];
    }
    if (json["usage"] != null) {
      usage = json["usage"];
    }

    sourceOthers = json["sourceOthers"] != null
        ? SourceOthers.fromJson(json["sourceOthers"])
        : null;
    if (json["source"] != null) {
      source = json["source"];
    }
    if (json["sourceNotInTheList"] != null) {
      sourceNotInTheList = json["sourceNotInTheList"];
    }

    if (json["newsLetters"] != null) {
      newsLetters = json["newsLetters"];
    }

    if (json["kyc"] != null) {
      kyc = json["kyc"];
    }

    if (json["assited"] != null) {
      assited = json["assited"];
    }

    if (json["referralLog"] != null) {
      referralLog = json["referralLog"];
    }
    if (json["referralCode"] != null) {
      referralCode = json["referralCode"];
    }
    if (json["myReferralCode"] != null) {
      myReferralCode = json["myReferralCode"];
    }
    if (json["referralLink"] != null) {
      referralLink = json["referralLink"];
    }
    referralBonus = json["referralBonus"] != null
        ? ReferralBonus.fromJson(json["referralBonus"])
        : null;

    if (json["createdAt"] != null) {
      createdAt = json["createdAt"];
    }
    individualUser = json["individualUser"] != null
        ? IndividualUser.fromJson(json["individualUser"])
        : null;
   
    company =
        json["company"] != null ? Company.fromJson(json["company"]) : null;

    if (json["administrator"] != null) {
      administrator = json["administrator"];
    }

    if (json["virtualAccountName"] != null) {
      virtualAccountName = json["virtualAccountName"];
    }
    if (json["virtualAccountNo"] != null) {
      virtualAccountNo = json["virtualAccountNo"];
    }
    if (json["department"] != null) {
      department = json["department"];
    }
    if (json["businessUnit"] != null) {
      businessUnit = json["businessUnit"];
    }
    baseStatus = json["baseStatus"] ?? true;
    message = json["message"] ?? '';
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "email": email,
        "status": status,
        "role": role,
        "usage": usage,
        "creationSource": creationSource,
        "source": source,
        "sourceOthers": sourceOthers!.toJson(),
        "sourceNotInTheList": sourceNotInTheList,
        "referralCode": referralCode,
        "referralLog": referralLog,
        "createdAt": createdAt,
        "individualUser": individualUser!.toJson(),
        "myReferralCode": myReferralCode,
        "referralLink": referralLink,
        "referralBonus": referralBonus!.toJson(),
        "company": company!.toJson(),
        "administrator": administrator,
        "virtualAccountName": virtualAccountName,
        "virtualAccountNo": virtualAccountNo,
        "userType": userType,
        "department": department,
        "businessUnit": businessUnit,
        "kyc": kyc,
        "assited": assited,
        "newsLetters": newsLetters,
      };
}

class ReferralBonus {
  ReferralBonus({
    this.id,
    this.totalRedeemedBonus,
    this.earnedReferralBonus,
    this.description,
    this.createdAt,
    this.poker,
    this.pokedUser,
  });

  int? id;
  double? totalRedeemedBonus;
  double? earnedReferralBonus;
  String? description;
  String? createdAt;
  dynamic poker;
  dynamic pokedUser;

  ReferralBonus.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    if (json["totalRedeemedBonus"] != null) {
      totalRedeemedBonus = json["totalRedeemedBonus"];
    }
    if (json["earnedReferralBonus"] != null) {
      earnedReferralBonus = json["earnedReferralBonus"];
    }
    if (json["description"] != null) {
      description = json["description"];
    }
    if (json["createdAt"] != null) {
      createdAt = json["createdAt"];
    }
    if (json["pokedUser"] != null) {
      pokedUser = json["pokedUser"];
    }
    if (json["poker"] != null) {
      poker = json["poker"];
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "totalRedeemedBonus": totalRedeemedBonus,
        "earnedReferralBonus": earnedReferralBonus,
        "description": description,
        "createdAt": createdAt,
        "poker": poker,
        "pokedUser": pokedUser,
      };
}

class SourceOthers {
  SourceOthers({
    this.id,
    this.name,
    this.description,
    this.status,
    this.createdAt,
  });

  int? id;
  String? name;
  String? description;
  String? status;
  String? createdAt;

  factory SourceOthers.fromJson(Map<String, dynamic> json) => SourceOthers(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        status: json["status"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "status": status,
        "createdAt": createdAt,
      };
}

class IndividualUser {
  IndividualUser({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.bvn,
    this.coutryOfResidence,
    this.secondaryPhoneNumber,
    this.state,
    this.lga,
    this.employmentDetail,
    this.nokDetail,
    this.maritalStatus,
    this.nationality,
    this.creditEmploymentDetail,
    this.occupationDetail,
    this.bankAccountVerified,
    this.validated,
  });

  int? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? dateOfBirth;
  Gender? gender;
  // String? address;
  Address? address;
  CoutryOfResidence? coutryOfResidence;
  String? bvn;

  String? secondaryPhoneNumber;
  String? state;
  String? lga;
  EmploymentDetail? employmentDetail;
  NextOfKinRes? nokDetail;
  // String? businessType;
  String? maritalStatus;
  dynamic? nationality;
  dynamic? creditEmploymentDetail;
  dynamic? occupationDetail;
  bool? bankAccountVerified;
  bool? validated;

  IndividualUser.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    if (json["firstName"] != null) {
      firstName = json["firstName"];
    }
    if (json["middleName"] != null) {
      middleName = json["middleName"];
    }
    if (json["lastName"] != null) {
      lastName = json["lastName"];
    }
    if (json["dateOfBirth"] != null) {
      dateOfBirth = json["dateOfBirth"];
    }
    if (json["gender"] != null) {
      gender = Gender.fromJson(json['gender']);

      // gender = json["gender"]["gender"];

    }
    if (json["maritalStatus"] != null) {
      maritalStatus = json["maritalStatus"];
    }

    address =
        json["address"] != null ? Address.fromJson(json["address"]) : null;
    // if (json["address"] != null) {
    //   address = json["address"];
    // }

    if (json["bvn"] != null) {
      bvn = json["bvn"];
    }

    coutryOfResidence = json["coutryOfResidence"] != null
        ? CoutryOfResidence.fromJson(json["coutryOfResidence"])
        : null;
    if (json["state"] != null) {
      state = json["state"];
    }
    if (json["lga"] != null) {
      lga = json["lga"];
    }
    nokDetail = json["nokDetail"] != null
        ? NextOfKinRes.fromJson(json["nokDetail"])
        : null;
    // if (json["nokDetail"] != null) {
    //   nokDetail = json["nokDetail"];
    // }
    if (json["occupationDetail"] != null) {
      occupationDetail = json["occupationDetail"];
    }
    if (json["creditEmploymentDetail"] != null) {
      creditEmploymentDetail = json["creditEmploymentDetail"];
    }
    // if (json["employmentDetail"] != null) {
    //   employmentDetail = json["employmentDetail"];
    // }
    employmentDetail = json['employmentDetail'] != null
        ? EmploymentDetail.fromJson(json["employmentDetail"])
        : null;

    if (json["nationality"] != null) {
      nationality = json["nationality"];
    }
    if (json["bankAccountVerified"] != null) {
      bankAccountVerified = json["bankAccountVerified"];
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "dateOfBirth": dateOfBirth,
        "maritalStatus": maritalStatus,
        "gender": gender,
        "bvn": bvn,
        // "address": address,
        "address": address!.toJson(),
        "coutryOfResidence": coutryOfResidence!.toJson(),
        "secondaryPhoneNumber": secondaryPhoneNumber,
        "state": state,
        "lga": lga,
        "employmentDetail": employmentDetail,
        "nokDetail": nokDetail,
        "creditEmploymentDetail": creditEmploymentDetail,
        "nationality": nationality,
        "occupationDetail": occupationDetail,
        "bankAccountVerified": bankAccountVerified,
        "validated": validated,
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

class NextOfKinRes {
  NextOfKinRes({
    this.address,
    this.email,
    this.id,
    this.name,
    this.phone,
    this.relationship,
  });

  String? address;
  String? email;
  int? id;
  String? name;
  String? phone;
  String? relationship;

  factory NextOfKinRes.fromJson(Map<String, dynamic> json) => NextOfKinRes(
        address: json["address"],
        email: json["email"],
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        relationship: json["relationship"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "email": email,
        "id": id,
        "name": name,
        "phone": phone,
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
        "name": name ?? '',
      };
}

class Company {
  Company({
    this.id,
    this.name,
    this.rcNumber,
    this.contactFirstName,
    this.contactMiddleName,
    this.contactLastName,
    this.dateOfInco,
    this.natureOfBusiness,
    this.companyType,
    this.companyAddress,
    this.businessType,
    this.useraccount,
    this.phone,
  });

  int? id;
  String? name;
  String? rcNumber;
  String? contactFirstName;
  String? contactMiddleName;
  String? contactLastName;
  String? dateOfInco;
  String? natureOfBusiness;
  String? companyType;
  String? companyAddress;
  String? businessType;
  dynamic useraccount;
  String? phone;

  Company.fromJson(Map<String, dynamic> json) {
    if (json["id"] != null) {
      id = json["id"];
    }
    name = json["name"];
    if (json["rcNumber"] != null) {
      rcNumber = json["rcNumber"];
    }

    contactFirstName = json["contactFirstName"];
    if (json["contactMiddleName"] != null) {
      contactMiddleName = json["contactMiddleName"] ?? "";
    }
    contactLastName = json["contactLastName"] ?? "";
    dateOfInco = json["dateOfInco"] ?? "";

    natureOfBusiness = json["natureOfBusiness"];
    companyType = json["companyType"];

    if (json["companyAddress"] != null) {
      companyAddress = json["companyAddress"];
    }
    if (json["useraccount"] != null) {
      useraccount = json["useraccount"];
    }
    if (json["businessType"] != null) {
      businessType = json["businessType"];
    }
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "rcNumber": rcNumber,
        "contactFirstName": contactFirstName,
        "contactMiddleName": contactMiddleName,
        "contactLastName": contactLastName,
        "dateOfInco": dateOfInco,
        "natureOfBusiness": natureOfBusiness,
        "companyType": companyType!.toUpperCase(),
        "companyAddress": companyAddress,
        "businessType": businessType,
        "useraccount": useraccount,
        "phone": phone,
      };
}
