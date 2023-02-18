// To parse this JSON data, do
//
//     final kycResponse = kycResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

KycResponse kycResponseFromJson(String str) =>
    KycResponse.fromJson(json.decode(str));

String kycResponseToJson(KycResponse data) => json.encode(data.toJson());

class KycResponse extends BaseResponse {
  KycResponse(
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
  String? referralBonus;
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

  KycResponse.fromJson(Map<String, dynamic> json) {
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
    if (json["referralBonus"] != null) {
      referralBonus = json["referralBonus"];
    }

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
        "referralBonus": referralBonus,
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
        "companyType": companyType,
        "companyAddress": companyAddress,
        "businessType": businessType,
        "useraccount": useraccount,
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
    this.city,
    this.maritalStatus,
    this.nationality,
    this.creditEmploymentDetail,
    this.occupationDetail,
    this.bankAccountVerified,
    this.secondaryPhoneVerified,
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
  String? city;
  EmploymentDetail? employmentDetail;
  NokDetail? nokDetail;
  // String? businessType;
  String? maritalStatus;
  dynamic? nationality;
  CreditEmploymentDetail? creditEmploymentDetail;
  dynamic? occupationDetail;
  bool? bankAccountVerified;
  bool? secondaryPhoneVerified;
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
      gender = json["gender"] != null ? Gender.fromJson(json["gender"]) : null;
    }
    if (json["maritalStatus"] != null) {
      maritalStatus = json["maritalStatus"];
    }
    if (json["address"] != null) {
      address =
          json["address"] != null ? Address.fromJson(json["address"]) : null;
    }
    if (json["bvn"] != null) {
      bvn = json["bvn"];
    }

    coutryOfResidence = json["coutryOfResidence"] != null
        ? CoutryOfResidence.fromJson(json["coutryOfResidence"])
        : null;
    if (json["state"] != null) {
      state = json["state"];
    }
    if (json["city"] != null) {
      city = json["city"];
    }
    if (json["lga"] != null) {
      lga = json["lga"];
    }
    if (json["employmentDetail"] != null) {
      employmentDetail = json["employmentDetail"] != null
          ? EmploymentDetail.fromJson(json["employmentDetail"])
          : null;
    }
    if (json["nokDetail"] != null) {
      nokDetail = json["nokDetail"] != null
          ? NokDetail.fromJson(json["nokDetail"])
          : null;
    }
    if (json["occupationDetail"] != null) {
      occupationDetail = json["occupationDetail"];
    }
    if (json["creditEmploymentDetail"] != null) {
      creditEmploymentDetail = json["creditEmploymentDetail"] != null
          ? CreditEmploymentDetail.fromJson(json["creditEmploymentDetail"])
          : null;
    }

    if (json["nationality"] != null) {
      nationality = json["nationality"];
    }
    if (json["bankAccountVerified"] != null) {
      bankAccountVerified = json["bankAccountVerified"];
    }
    if (json["secondaryPhoneVerified"] != null) {
      secondaryPhoneVerified = json["secondaryPhoneVerified"];
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "dateOfBirth": dateOfBirth,
        "gender": gender!.toJson(),
        "address": address!.toJson(),
        "bvn": bvn,
        "coutryOfResidence": coutryOfResidence!.toJson(),
        "state": state,
        "lga": lga,
        "employmentDetail": employmentDetail!.toJson(),
        "creditEmploymentDetail": creditEmploymentDetail!.toJson(),
        "occupationDetail": occupationDetail,
        "nokDetail": nokDetail!.toJson(),
        "maritalStatus": maritalStatus,
        "secondaryPhoneNumber": secondaryPhoneNumber,
        "city": city,
        "bankAccountVerified": bankAccountVerified,
        "secondaryPhoneVerified": secondaryPhoneVerified,
        "nationality": nationality,
      };
}

class Address {
  Address({
    this.id,
    this.houseNoAddress,
    this.postCode,
    this.latitude,
    this.longitude,
    this.city,
    this.state,
    this.lga,
    this.country,
    this.streetAddress,
    this.homeAddress,
    this.nationality,
    this.secondaryPhoneNumber,
  });

  int? id;
  String? houseNoAddress;
  String? postCode;
  double? latitude;
  double? longitude;
  String? city;
  String? state;
  String? lga;
  String? country;
  String? streetAddress;
  String? homeAddress;
  String? nationality;
  String? secondaryPhoneNumber;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        houseNoAddress: json["houseNoAddress"],
        postCode: json["postCode"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        city: json["city"],
        state: json["state"],
        lga: json["lga"],
        country: json["country"],
        streetAddress: json["streetAddress"],
        homeAddress: json["homeAddress"],
        nationality: json["nationality"],
        secondaryPhoneNumber: json["secondaryPhoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "houseNoAddress": houseNoAddress,
        "postCode": postCode,
        "latitude": latitude,
        "longitude": longitude,
        "city": city,
        "state": state,
        "lga": lga,
        "country": country,
        "streetAddress": streetAddress,
        "homeAddress": homeAddress,
        "nationality": nationality,
        "secondaryPhoneNumber": secondaryPhoneNumber,
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

class CreditEmploymentDetail {
  CreditEmploymentDetail({
    this.id,
    this.employerName,
    this.employerAddress,
    this.sector,
    this.employmentId,
    this.industry,
    this.officeEmailAddress,
    this.payrollHandler,
    this.payrollHandlerDetails,
    this.industryDetails,
    this.ippisNumber,
    this.createdAt,
  });

  int? id;
  String? employerName;
  String? employerAddress;
  String? sector;
  int? employmentId;
  String? industry;
  String? officeEmailAddress;
  String? payrollHandler;
  dynamic? payrollHandlerDetails;
  dynamic? industryDetails;
  String? ippisNumber;
  String? createdAt;

  CreditEmploymentDetail.fromJson(Map<String, dynamic> json) {
    if (json["id"] != null) {
      id = json["id"];
    }
    if (json["employerName"] != null) {
      employerName = json["employerName"];
    }
    if (json["employerAddress"] != null) {
      employerAddress = json["employerAddress"];
    }
    if (json["sector"] != null) {
      sector = json["sector"];
    }
    if (json["industry"] != null) {
      industry = json["industry"];
    }
    if (json["employmentId"] != null) {
      employmentId = json["employmentId"];
    }
    if (json["officeEmailAddress"] != null) {
      officeEmailAddress = json["officeEmailAddress"];
    }
    if (json["payrollHandler"] != null) {
      payrollHandler = json["payrollHandler"];
    }
    if (json["payrollHandlerDetails"] != null) {
      payrollHandlerDetails = json["payrollHandlerDetails"];
    }
    if (json["industryDetails"] != null) {
      industryDetails = json["industryDetails"];
    }
    if (json["ippisNumber"] != null) {
      ippisNumber = json["ippisNumber"];
    }
    if (json["createdAt"] != null) {
      createdAt = json["createdAt"];
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "employerName": employerName,
        "employerAddress": employerAddress,
        "sector": sector,
        "employmentId": employmentId,
        "industry": industry,
        "officeEmailAddress": officeEmailAddress,
        "payrollHandler": payrollHandler,
        "payrollHandlerDetails": payrollHandlerDetails,
        "industryDetails": industryDetails,
        "ippisNumber": ippisNumber,
        "createdAt": createdAt,
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

class Gender {
  Gender({
    this.id,
    this.gender,
    this.description,
    this.status,
    this.createdAt,
  });

  int? id;
  String? gender;
  String? description;
  String? status;
  String? createdAt;

  Gender.fromJson(Map<String, dynamic> json) {
    if (json["id"] != null) {
      id = json["id"];
    }
    if (json["gender"] != null) {
      gender = json["gender"];
    }
    if (json["description"] != null) {
      description = json["description"];
    }
    if (json["status"] != null) {
      status = json["status"];
    }
    if (json["createdAt"] != null) {
      createdAt = json["createdAt"];
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "gender": gender,
        "description": description,
        "status": status,
        "createdAt": createdAt,
      };
}

class NokDetail {
  NokDetail({
    this.id,
    this.name,
    this.address,
    this.email,
    this.phone,
  });

  int? id;
  String? name;
  String? address;
  String? email;
  String? phone;

  factory NokDetail.fromJson(Map<String, dynamic> json) => NokDetail(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "email": email,
        "phone": phone,
      };
}
