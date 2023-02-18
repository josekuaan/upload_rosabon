// To parse this JSON data, do
//
//     final personalInformationRequest = personalInformationRequestFromJson(jsonString);

import 'dart:convert';

PersonalInformationRequest personalInformationRequestFromJson(String str) =>
    PersonalInformationRequest.fromJson(json.decode(str));

String personalInformationRequestToJson(PersonalInformationRequest data) =>
    json.encode(data.toJson());

class PersonalInformationRequest {
  PersonalInformationRequest({
    this.address,
    this.countryId,
    this.employmentDetail,
    this.lgaId,
    this.nokDetail,
    this.secondaryPhone,
    this.stateId,
  });

  ContactAddress? address;
  int? countryId;
  EpDetail? employmentDetail;
  int? lgaId;
  NokDetail? nokDetail;
  String? secondaryPhone;
  int? stateId;

  PersonalInformationRequest.fromJson(Map<String, dynamic> json) {
    if (json["address"] != null) {
      address = ContactAddress.fromJson(json["address"]);
    }
    if (json["countryId"] != null) {
      countryId = json["countryId"];
    }

    if (json["lgemploymentDetailaId"] != null) {
      employmentDetail = EpDetail.fromJson(json["employmentDetail"]);
    }
    if (json["lgaId"] != null) {
      lgaId = json["lgaId"];
    }
    if (json["secondaryPhone"] != null) {
      secondaryPhone = json["secondaryPhone"];
    }

    if (json["stateId"] != null) {
      stateId = json["stateId"];
    }
    if (json["nokDetail"] != null) {
      nokDetail = NokDetail.fromJson(json["nokDetail"]);
    }
  }

  Map<String, dynamic> toJson() => {
        "address": address == null ? null : address!.toJson(),
        "countryId": countryId,
        "employmentDetail":
            employmentDetail == null ? null : employmentDetail!.toJson(),
        "lgaId": lgaId,
        "nokDetail": nokDetail == null ? null : nokDetail!.toJson(),
        "secondaryPhone": secondaryPhone,
        "stateId": stateId,
      };
}

class ContactAddress {
  ContactAddress({
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

  ContactAddress.fromJson(Map<String, dynamic> json) {
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

class EpDetail {
  EpDetail({
    this.employerAddress,
    this.employerName,
    this.occupation,
  });

  String? employerAddress;
  String? employerName;
  String? occupation;

  factory EpDetail.fromJson(Map<String, dynamic> json) => EpDetail(
        employerAddress: json["employerAddress"],
        employerName: json["employerName"],
        occupation: json["occupation"],
      );

  Map<String, dynamic> toJson() => {
        "employerAddress": employerAddress,
        "employerName": employerName,
        "occupation": occupation,
      };
}

class NokDetail {
  NokDetail({
    this.nokAddress,
    this.email,
    this.name,
    this.phone,
  });

  String? nokAddress;
  String? email;
  String? name;
  String? phone;

  factory NokDetail.fromJson(Map<String, dynamic> json) => NokDetail(
        nokAddress: json["nokAddress"],
        email: json["email"],
        name: json["name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "nokAddress": nokAddress,
        "email": email,
        "name": name,
        "phone": phone,
      };
}
