import 'dart:async';

import 'package:rosabon/repository/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static final SessionManager _sessionManager = SessionManager.internal();

  factory SessionManager() => _sessionManager;
  SessionManager.internal();

  late SharedPreferences sharedPreferences;

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static const String authToken = "auth_token";
  static const String status = "status";
  static const String userDevice = "userDevice";
  static const String userId = "user_id";
  static const String timeZone = "time_zone";
  static const String loggedIn = "logged_in";
  static const String isKyc = "is_kyc";
  static const String assisted = "assisted";
  static const String otp = "otp";
  static const String newsLetter = "news_letter";
  static const String userData = "user_data";
  static const String userRole = "user_role";
  static const String usage = "usage";
  static const String userEmail = "userEmail";
  static const String userFullName = "user_full_name";
  static const String firstName = "first_name";
  static const String lastName = "last_name";
  static const String phone = "phone";
  static const String companyName = "company_name";
  static const String sourceOthers = "source_others";
  static const String referalCode = "referal_code";
  static const String referralLink = "referralLink";
  static const String source = "source";
  static const String virtualAccountNo = "virtualAccountNo";
  static const String virtualAccountName = "virtualAccountName";
  static const String activePlan = "activePlan";
  static const String totalWorth = "totalWorth";
  static const String creationSource = "creationSource";
  static const String resetPassword = "resetPassword";

  Future<bool> logout() async {
    var res = await AuthRepository().logout();
    if (res.baseStatus) {
      return true;
    } else {
      return false;
    }
  }

  set loggedInVal(bool val) => sharedPreferences.setBool(loggedIn, val);
  bool get loggedInVal => sharedPreferences.getBool(loggedIn) ?? false;

  set isKycVal(bool val) => sharedPreferences.setBool(isKyc, val);
  bool get isKycVal => sharedPreferences.getBool(isKyc) ?? false;
  set newsletterVal(bool val) => sharedPreferences.setBool(newsLetter, val);
  bool get newsletterVal => sharedPreferences.getBool(newsLetter) ?? false;

  set resetPasswordStatus(bool val) =>
      sharedPreferences.setBool(resetPassword, val);
  bool get resetPasswordStatus =>
      sharedPreferences.getBool(resetPassword) ?? false;
  set assistedVal(bool val) => sharedPreferences.setBool(assisted, val);
  bool get assistedVal => sharedPreferences.getBool(assisted) ?? false;
  set statusVal(String val) => sharedPreferences.setString(status, val);
  String get statusVal => sharedPreferences.getString(status) ?? "";
  set usageVal(String val) => sharedPreferences.setString(usage, val);
  String get usageVal => sharedPreferences.getString(usage) ?? "";
  set userDeviceVal(String val) => sharedPreferences.setString(userDevice, val);
  String get userDeviceVal => sharedPreferences.getString(userDevice) ?? "";

  set creationSourceType(String val) =>
      sharedPreferences.setString(creationSource, val);
  String get creationSourceType =>
      sharedPreferences.getString(creationSource) ?? "";
  set sourceVal(String val) => sharedPreferences.setString(source, val);
  String get sourceVal => sharedPreferences.getString(source) ?? "";
  set sourceOthersVal(String val) =>
      sharedPreferences.setString(sourceOthers, val);
  String get sourceOthersVal => sharedPreferences.getString(sourceOthers) ?? "";
  set referalCodeVal(String val) =>
      sharedPreferences.setString(referalCode, val);
  String get referalCodeVal => sharedPreferences.getString(referalCode) ?? "";
  set referralLinkVal(String val) =>
      sharedPreferences.setString(referralLink, val);
  String get referralLinkVal => sharedPreferences.getString(referralLink) ?? "";
  set authTokenVal(String val) => sharedPreferences.setString(authToken, val);
  String get authTokenVal => sharedPreferences.getString(authToken) ?? "";
  set userdataval(String val) => sharedPreferences.setString(userData, val);
  String get userdataval => sharedPreferences.getString(userData) ?? "";

  set userEmailVal(String val) => sharedPreferences.setString(userEmail, val);
  String get userEmailVal => sharedPreferences.getString(userEmail) ?? "";
  set phoneVal(String val) => sharedPreferences.setString(phone, val);
  String get phoneVal => sharedPreferences.getString(phone) ?? "";

  set userRoleVal(String val) => sharedPreferences.setString(userRole, val);
  String get userRoleVal => sharedPreferences.getString(userRole) ?? "";

  set userFullNameVal(String val) =>
      sharedPreferences.setString(userFullName, val);
  String get userFullNameVal => sharedPreferences.getString(userFullName) ?? "";

  set virtualAccountNameVAl(String val) =>
      sharedPreferences.setString(virtualAccountName, val);
  String get virtualAccountNameVAl =>
      sharedPreferences.getString(virtualAccountName) ?? "";

  set virtualAccountNoVal(String val) =>
      sharedPreferences.setString(virtualAccountNo, val);
  String get virtualAccountNoVal =>
      sharedPreferences.getString(virtualAccountNo) ?? "";

  set firstNameVal(String val) => sharedPreferences.setString(firstName, val);
  String get firstNameVal => sharedPreferences.getString(firstName) ?? "";
  set lastNameVal(String val) => sharedPreferences.setString(lastName, val);
  String get lastNameVal => sharedPreferences.getString(lastName) ?? "";
  set otpVal(String val) => sharedPreferences.setString(otp, val);
  String get otpVal => sharedPreferences.getString(otp) ?? "";
  set companyNameVal(String val) =>
      sharedPreferences.setString(companyName, val);
  String get companyNameVal => sharedPreferences.getString(companyName) ?? "";
  set userDataVal(String val) => sharedPreferences.setString(userData, val);
  String get userDataval => sharedPreferences.getString(userData) ?? "";
  int get activePlanVal => sharedPreferences.getInt(activePlan) ?? 0;
  set activePlanVal(int val) => sharedPreferences.setInt(activePlan, val);

  set userIdVal(int val) => sharedPreferences.setInt(userId, val);
  int get userIdVal => sharedPreferences.getInt(userId) ?? 0;
  set totalWorthVal(int val) => sharedPreferences.setInt(totalWorth, val);
  int get totalWorthVal => sharedPreferences.getInt(totalWorth) ?? 0;
}
