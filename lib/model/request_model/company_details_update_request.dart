// To parse this JSON data, do
//
//     final companyDetailsUpdateequest = companyDetailsUpdateequestFromJson(jsonString);

import 'dart:convert';

CompanyDetailsUpdateequest companyDetailsUpdateequestFromJson(String str) =>
    CompanyDetailsUpdateequest.fromJson(json.decode(str));

String companyDetailsUpdateequestToJson(CompanyDetailsUpdateequest data) =>
    json.encode(data.toJson());

class CompanyDetailsUpdateequest {
  CompanyDetailsUpdateequest({
    this.companyAddress,
    this.companyType,
    this.contactFirstName,
    this.contactLastName,
    this.contactMiddleName,
    this.dateOfInco,
    this.name,
    this.natureOfBusiness,
    this.rcNumber,
    this.phone,
    this.email,
  });

  String? companyAddress;
  String? companyType;
  String? contactFirstName;
  String? contactLastName;
  String? contactMiddleName;
  String? dateOfInco;
  String? name;
  String? natureOfBusiness;
  String? rcNumber;
  String? phone;
  String? email;

  factory CompanyDetailsUpdateequest.fromJson(Map<String, dynamic> json) =>
      CompanyDetailsUpdateequest(
          companyAddress: json["companyAddress"],
          companyType: json["companyType"],
          contactFirstName: json["contactFirstName"],
          contactLastName: json["contactLastName"],
          contactMiddleName: json["contactMiddleName"],
          dateOfInco: json["dateOfInco"],
          name: json["name"],
          natureOfBusiness: json["natureOfBusiness"],
          rcNumber: json["rcNumber"],
          phone: json["phone"],
          email: json["email"]);

  Map<String, dynamic> toJson() {
    // {
    // "companyAddress": companyAddress,
    // "companyType": companyType,
    // "contactFirstName": contactFirstName,
    // "contactLastName": contactLastName,
    // "contactMiddleName": contactMiddleName,
    // // "dateOfInco": dateOfInco,
    // "email":email,
    // "name": name,
    // "natureOfBusiness": natureOfBusiness,
    // "phone": phone,
    // // "rcNumber": ,
    final Map<String, dynamic> data = {};
    if (companyAddress != null) {
      data["companyAddress"] = companyAddress;
    }
    if (companyType != null) {
      data["companyType"] = companyType!.toUpperCase();
    }
    if (contactFirstName != null) {
      data["contactFirstName"] = contactFirstName;
    }
    if (contactMiddleName != null) {
      data["contactMiddleName"] = contactMiddleName;
    }
    if (email != null) {
      data["email"] = email;
    }
    if (name != null) {
      data["name"] = name;
    }
    if (natureOfBusiness != null) {
      data["natureOfBusiness"] = natureOfBusiness;
    }
    if (phone != null) {
      data["phone"] = phone;
    }
    if (rcNumber != null) {
      data["rcNumber"] = rcNumber;
    }
    if (dateOfInco != null) {
      data["dateOfInco"] = dateOfInco;
    }

    return data;
  }
}
