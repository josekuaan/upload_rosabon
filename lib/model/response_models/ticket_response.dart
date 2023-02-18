// To parse this JSON data, do
//
//     final ticketResponse = ticketResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rosabon/model/response_models/base_response.dart';

TicketResponse ticketResponseFromJson(String str) =>
    TicketResponse.fromJson(json.decode(str));

String ticketResponseToJson(TicketResponse data) => json.encode(data.toJson());

class TicketResponse extends BaseResponse {
  TicketResponse({this.ticket, message, baseStatus})
      : super(baseStatus: baseStatus, message: message);

  List<Ticket>? ticket;

  factory TicketResponse.fromJson(Map<String, dynamic> json) => TicketResponse(
        ticket:
            List<Ticket>.from(json["ticket"].map((x) => Ticket.fromJson(x))),
        baseStatus: json["baseStatus"] ?? true,
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "ticket": List<dynamic>.from(ticket!.map((x) => x.toJson())),
        "message": message,
        "baseStatus": baseStatus,
      };
}

class Ticket {
  Ticket({
    this.id,
    this.title,
    this.individualUser,
    this.company,
    this.message,
    this.category,
    this.status,
    this.createdAt,
  });

  int? id;
  String? title;
  IndividualUser? individualUser;
  Company? company;
  String? message;
  Category? category;
  String? status;
  String? createdAt;

  Ticket.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    if (json["individualUser"] != null) {
      individualUser = IndividualUser.fromJson(json["individualUser"]);
    }
    if (json["company"] != null) {
      company = Company.fromJson(json["company"]);
    }
    if (json["message"] != null) {
      message = json["message"];
    }
    category = Category.fromJson(json["category"]);
    status = json["status"];
    createdAt = json["createdAt"];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "individualUser": individualUser!.toJson(),
        "company": company!.toJson(),
        "message": message,
        "category": category!.toJson(),
        "status": status,
        "createdAt": createdAt
      };
}

class Category {
  Category({
    this.id,
    this.name,
    this.status,
    this.description,
  });

  int? id;
  String? name;
  String? status;
  String? description;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "description": description,
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
    rcNumber = json["rcNumber"];

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
    this.state,
    this.lga,
    this.employmentDetail,
    this.nokDetail,
    this.secondaryPhoneNumber,
    this.bankAccountVerified,
    this.secondaryPhoneVerified,
  });

  int? id;
  String? firstName;
  dynamic? middleName;
  String? lastName;
  String? dateOfBirth;
  String? gender;
  Address? address;
  String? bvn;
  CoutryOfResidence? coutryOfResidence;
  String? state;
  String? lga;
  EmploymentDetail? employmentDetail;
  NokDetailTicket? nokDetail;
  String? secondaryPhoneNumber;
  bool? bankAccountVerified;
  bool? secondaryPhoneVerified;

  IndividualUser.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    firstName = json["firstName"];
    if (json["middleName"] != null) {
      middleName = json["middleName"];
    }
    lastName = json["lastName"];
    dateOfBirth = json["dateOfBirth"];

    if (json["gender"] != null) {
      gender = json["gender"];
    }
    address =
        json["address"] != null ? Address.fromJson(json["address"]) : null;
    coutryOfResidence = CoutryOfResidence.fromJson(json["coutryOfResidence"]);
    bvn = json["bvn"];

    if (json["state"] != null) {
      state = json["state"];
    }

    if (json["lga"] != null) {
      lga = json["lga"];
    }

    employmentDetail = json["employmentDetail"] != null
        ? EmploymentDetail.fromJson(json["employmentDetail"])
        : null;
    nokDetail = json["nokDetail"] != null
        ? NokDetailTicket.fromJson(json["nokDetail"])
        : null;
    if (json["secondaryPhoneNumber"] != null) {
      secondaryPhoneNumber = json["secondaryPhoneNumber"];
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
        "gender": gender,
        "address": address!.toJson(),
        "bvn": bvn,
        "coutryOfResidence": coutryOfResidence!.toJson(),
        "state": state,
        "lga": lga,
        "employmentDetail": employmentDetail!.toJson(),
        "nokDetail": nokDetail!.toJson(),
        "secondaryPhoneNumber": secondaryPhoneNumber,
        "bankAccountVerified": bankAccountVerified,
        "secondaryPhoneVerified": secondaryPhoneVerified,
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
  });

  int? id;
  String? houseNoAddress;
  String? postCode;
  dynamic? latitude;
  dynamic? longitude;
  String? city;
  String? state;
  String? lga;
  String? country;

  Address.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    houseNoAddress = json["houseNoAddress"];
    if (json["postCode"] != null) {
      postCode = json["postCode"];
    }
    if (json["latitude"] != null) {
      latitude = json["latitude"];
    }
    if (json["longitude"] != null) {
      longitude = json["longitude"];
    }
    if (json["city"] != null) {
      city = json["city"];
    }
    if (json["lga"] != null) {
      lga = json["lga"];
    }
    if (json["country"] != null) {
      country = json["country"];
    }
  }

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

class NokDetailTicket {
  NokDetailTicket({
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

  factory NokDetailTicket.fromJson(Map<String, dynamic> json) =>
      NokDetailTicket(
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
