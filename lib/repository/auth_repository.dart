import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rosabon/bloc/auth/countryApi/countri_api_bloc.dart';
import 'package:rosabon/bloc/auth/user/user_bloc.dart';
import 'package:rosabon/model/request_model/bvn_request.dart';
import 'package:rosabon/model/request_model/forgot_password_request.dart';
import 'package:rosabon/model/request_model/kyc_request.dart';
import 'package:rosabon/model/request_model/login_request.dart';
import 'package:rosabon/model/request_model/register_token_request.dart';
import 'package:rosabon/model/request_model/reset_password.dart';
import 'package:rosabon/model/request_model/sign_up_request.dart';
import 'package:rosabon/model/request_model/updateBvnName.dart';
import 'package:rosabon/model/response_models/base_response.dart';
import 'package:rosabon/model/response_models/bvn_response.dart';
import 'package:rosabon/model/response_models/change_password_response.dart';
import 'package:rosabon/model/response_models/country_response.dart';
import 'package:rosabon/model/response_models/forgot_password_response.dart';
import 'package:rosabon/model/response_models/gender_response.dart';
import 'package:rosabon/model/response_models/kyc_response.dart';
import 'package:rosabon/model/response_models/login_response.dart';
import 'package:rosabon/model/response_models/notification_response.dart';
import 'package:rosabon/model/response_models/sign_up_response.dart';
import 'package:rosabon/model/response_models/source_response.dart';
import 'package:rosabon/model/response_models/state_response.dart';
import 'package:rosabon/model/response_models/user_response.dart';
import 'package:rosabon/newtwork/network_config/app_config.dart';
import 'package:rosabon/newtwork/network_provider/network_provider.dart';
import 'package:rosabon/session_manager/session_manager.dart';

class AuthRepository {
  final NetworkProvider _networkProvider = NetworkProvider();
  final SessionManager sessionManager = SessionManager();

  Future<void> persistEmail(String email) async {
    sessionManager.userEmailVal = email;
    return;
  }

  Future<void> persistPhone(String phone) async {
    sessionManager.phoneVal = phone;
    return;
  }

  Future<void> persistUserId(int userId) async {
    sessionManager.userIdVal = userId;
    return;
  }

  Future<void> persistUser(String user) async {
    sessionManager.userdataval = user;
    return;
  }

  Future<void> persistTotalnetworth(int totalWorth) async {
    sessionManager.totalWorthVal = totalWorth;
    return;
  }

  Future<void> persistToken(String token) async {
    sessionManager.authTokenVal = token;
    return;
  }

  Future<void> persistCompanyName(String name) async {
    sessionManager.companyNameVal = name;
    return;
  }

  Future<void> persistFullName(String fullName) async {
    sessionManager.userFullNameVal = fullName;
    return;
  }

  Future<void> persistvirtualAccountName(String name) async {
    sessionManager.virtualAccountNameVAl = name;
    return;
  }

  Future<void> persistvirtualAccountNo(String number) async {
    sessionManager.virtualAccountNoVal = number;
    return;
  }

  Future<void> persistFirstName(String firstName) async {
    sessionManager.firstNameVal = firstName;
    return;
  }

  Future<void> persistLastName(String lastName) async {
    sessionManager.lastNameVal = lastName;
    return;
  }

  Future<void> persistUserRole(String role) async {
    sessionManager.userRoleVal = role;
    return;
  }

  Future<void> persistLoggedInVal(bool isauth) async {
    sessionManager.loggedInVal = isauth;
    return;
  }

  Future<void> persistIsKyc(bool kyc) async {
    sessionManager.isKycVal = kyc;
    return;
  }

  Future<void> persistNewsletter(bool newsletter) async {
    sessionManager.newsletterVal = newsletter;
    return;
  }

  Future<void> persistAssited(bool assisted) async {
    sessionManager.assistedVal = assisted;
    return;
  }

  Future<void> resetPasswordStatus(bool resetPassword) async {
    sessionManager.resetPasswordStatus = resetPassword;
    return;
  }

  Future<void> persistSourceOthers(String source) async {
    sessionManager.sourceOthersVal = source;
    return;
  }

  Future<void> persistReferralCode(String code) async {
    sessionManager.referalCodeVal = code;
    return;
  }

  Future<void> persistReferralLink(String code) async {
    sessionManager.referralLinkVal = code;
    return;
  }

  Future<void> persistSource(String source) async {
    sessionManager.sourceVal = source;
    return;
  }

  Future<void> persistStatus(String status) async {
    sessionManager.statusVal = status;
    return;
  }

  Future<void> creationSource(String creationSource) async {
    sessionManager.creationSourceType = creationSource;
    return;
  }

  Future<void> persistUsage(String usage) async {
    sessionManager.usageVal = usage;
    return;
  }

  Future<void> persistUserDevice(String device) async {
    sessionManager.userDeviceVal = device;
    return;
  }

  Future<SignUpReponse> signup(SignUpRequest signUpRequest) async {
    late SignUpReponse signUpReponse;
    try {
      final encoded = jsonEncode(signUpRequest.toJson());

      final response = await _networkProvider.call(
          body: encoded, path: AppConfig.signup, method: RequestMethod.post);

      if (response!.statusCode == 200) {
        signUpReponse = SignUpReponse.fromJson(response.data);

        signUpReponse.baseStatus = true;
      } else {
        // loginResponse.status = false;
      }
    } on DioError catch (e) {
      signUpReponse = SignUpReponse(message: e.message, baseStatus: false);
    }

    return signUpReponse;
  }

  Future<LoginResponse> requesterTokn(
      RegisterTokenRequest registerTokenRequest) async {
    late LoginResponse loginResponse;
    try {
      final encode = jsonEncode(registerTokenRequest.toJson());

      final response = await _networkProvider.call(
          queryParams: {"platform": "TREASURY"},
          body: encode,
          path: AppConfig.registertoken,
          method: RequestMethod.post);

      if (response!.statusCode == 200) {
        loginResponse = LoginResponse.fromJson(response.data);

        loginResponse.baseStatus = true;
      } else {
        // loginResponse.status = false;
      }
    } on DioError catch (e) {
      loginResponse = LoginResponse(message: e.message, baseStatus: false);
    }

    return loginResponse;
  }

  Future<SourceResponse> getSource() async {
    late SourceResponse sourceResponse;
    try {
      final response = await _networkProvider.call(
          queryParams: {"status": "ACTIVE"},
          path: AppConfig.getSource,
          method: RequestMethod.get);

      if (response!.statusCode == 200) {
        response.data.add({
          "id": 0,
          "name": "Source Not In The List",
          "description": "",
          "status": "",
          "createdAt": DateTime.parse("2012-02-27").toString(),
        });
        sourceResponse = SourceResponse.fromJson({"sources": response.data});

        sourceResponse.baseStatus = true;
      } else {
        // loginResponse.status = false;
      }
    } on DioError catch (e) {
      sourceResponse = SourceResponse(message: e.message, baseStatus: false);
    }

    return sourceResponse;
  }

  Future<GenderResponse> gender() async {
    late GenderResponse genderResponse;
    try {
      final response = await _networkProvider.call(
          queryParams: {"status": "ACTIVE"},
          path: AppConfig.gender,
          method: RequestMethod.get);

      if (response!.statusCode == 200) {
        genderResponse = GenderResponse.fromJson({"gender": response.data});
        genderResponse.baseStatus = true;
      } else {
        // loginResponse.status = false;
      }
    } on DioError catch (e) {
      genderResponse = GenderResponse(message: e.message, baseStatus: false);
    }

    return genderResponse;
  }

  Future<LoginResponse> login(Loginrequest loginrequest) async {
    late LoginResponse loginResponse;
    try {
      final encode = jsonEncode(loginrequest.toJson());

      final response = await _networkProvider.call(
          body: encode, path: AppConfig.login, method: RequestMethod.post);

      if (response!.statusCode == 428) {
        loginResponse = LoginResponse(
            message:
                "Your account is pending verification. Please check your email for the verification link",
            baseStatus: false);
      }

      if (response.statusCode == 200) {
        loginResponse = LoginResponse.fromJson(response.data);

        loginResponse.baseStatus = true;
      } else {
        // loginResponse.status = false;
      }
    } on DioError catch (e) {
      loginResponse = LoginResponse(message: e.message, baseStatus: false);
    }

    return loginResponse;
  }

  Future<UserResponse> userDetails(FetchUser e) async {
    late UserResponse userResponse;
    try {
      final response = await _networkProvider.call(
          path: AppConfig.userDetails, method: RequestMethod.get);

      if (response!.statusCode == 200) {
        userResponse = UserResponse.fromJson(response.data);

        userResponse.baseStatus = true;
      } else {
        userResponse =
            UserResponse(message: "Something went wrong", baseStatus: false);
      }
    } catch (e) {
      print(e);
      userResponse = UserResponse(message: e, baseStatus: false);
    }

    return userResponse;
  }

  // Future<UserResponse> user(FetchUser e) async {
  //   late UserResponse userResponse;
  //   try {
  //     final response = await _networkProvider.call(
  //         path: AppConfig.user(e.name), method: RequestMethod.get);

  //     if (response!.statusCode == 200) {
  //       userResponse = UserResponse.fromJson(response.data);

  //       userResponse.baseStatus = true;
  //     } else {
  //       userResponse =
  //           UserResponse(message: "Something went wrong", baseStatus: false);
  //     }
  //   } catch (e) {
  //     print(e);
  //     userResponse = UserResponse(message: e, baseStatus: false);
  //   }

  //   return userResponse;
  // }

  Future<ForgotPasswordResponse> forgotPassword(
      ForgotPasswordRequest forgotPasswordRequest) async {
    late ForgotPasswordResponse forgotPasswordResponse;
    try {
      // final encode = jsonEncode(forgotPasswordRequest.toJson());
      final response = await _networkProvider.call(
          // body: encode,
          path: AppConfig.forgotpassword(
            forgotPasswordRequest.email.toString(),
          ),
          method: RequestMethod.post);

      if (response!.statusCode == 200) {
        forgotPasswordResponse = ForgotPasswordResponse.fromJson(response.data);
        forgotPasswordResponse.baseStatus = true;
      } else {
        forgotPasswordResponse = ForgotPasswordResponse(
            baseStatus: false, message: response.statusMessage);
      }
    } on DioError catch (e) {
      forgotPasswordResponse =
          ForgotPasswordResponse(message: e.message, baseStatus: false);
    }

    return forgotPasswordResponse;
  }

  Future<ChangePasswordResponse> changePassword(
      ChangePasswordRequest changePasswordRequest) async {
    late ChangePasswordResponse changePasswordResponse;
    try {
      final encode = jsonEncode(changePasswordRequest.toJson());
      final response = await _networkProvider.call(
          body: encode,
          path: AppConfig.changepassword,
          method: RequestMethod.post);

      if (response!.statusCode == 200) {
        changePasswordResponse = ChangePasswordResponse.fromJson(response.data);
        changePasswordResponse.baseStatus = true;
      } else {
        changePasswordResponse = ChangePasswordResponse(baseStatus: false);
      }
    } on DioError catch (e) {
      changePasswordResponse =
          ChangePasswordResponse(message: e.message, baseStatus: false);
    }

    return changePasswordResponse;
  }

  Future<BaseResponse> resetPassword(
      ResetPasswordRequest resetPasswordRequest) async {
    late BaseResponse baseResponse;
    try {
      final encode = jsonEncode(resetPasswordRequest.toJson());
      final response = await _networkProvider.call(
          body: encode,
          path: AppConfig.resestPassword,
          method: RequestMethod.post);

      if (response!.statusCode == 200) {
        baseResponse = BaseResponse(message: "", baseStatus: true);
      } else {
        baseResponse = BaseResponse(baseStatus: false);
      }
    } on DioError catch (e) {
      baseResponse = BaseResponse(message: e.message, baseStatus: false);
    }

    return baseResponse;
  }

  Future<KycResponse> kyc(KycRequest kycRequest) async {
    late KycResponse kycResponse;
    try {
      final encode = jsonEncode(kycRequest);
      final response = await _networkProvider.call(
          body: encode, path: AppConfig.kyc, method: RequestMethod.put);

      if (response!.statusCode == 200) {
        kycResponse = KycResponse.fromJson(response.data);
        kycResponse.baseStatus = true;
      } else {
        kycResponse = KycResponse(baseStatus: false);
      }
    } on DioError catch (e) {
      kycResponse = KycResponse(message: e.message, baseStatus: false);
    }

    return kycResponse;
  }

  Future<BaseResponse> updateBvnName(
      UpdateBvnNameRequest updateBvnNameRequest) async {
    late BaseResponse baseResponse;
    try {
      final encode = jsonEncode(updateBvnNameRequest);
      final response = await _networkProvider.call(
          body: encode,
          path: AppConfig.updateBvnName,
          method: RequestMethod.put);

      if (response!.statusCode == 200) {
        baseResponse = BaseResponse(baseStatus: true, message: "");
      }
    } on DioError catch (e) {
      baseResponse = BaseResponse(message: e.message, baseStatus: false);
    }

    return baseResponse;
  }

  Future<CountryResponse> fetchCountries(Fetch e) async {
    late CountryResponse countryResponse;
    try {
      final response = await _networkProvider.call(
          // body: encode,
          path: AppConfig.countries,
          method: RequestMethod.get);

      if (response!.statusCode == 200) {
        countryResponse =
            CountryResponse.fromJson({"countries": response.data});
        countryResponse.baseStatus = true;
      } else {
        countryResponse = CountryResponse(baseStatus: false);
      }
    } on DioError catch (e) {
      countryResponse = CountryResponse(message: e.message, baseStatus: false);
    }

    return countryResponse;
  }

  Future<StateResponse> fetchState(Fetch e) async {
    late StateResponse stateResponse;
    try {
      final response = await _networkProvider.call(
          // body: encode,
          path: AppConfig.state(e.id!),
          method: RequestMethod.get);

      if (response!.statusCode == 200) {
        stateResponse = StateResponse.fromJson({"state": response.data});
        stateResponse.baseStatus = true;
      } else {
        stateResponse = StateResponse(baseStatus: false);
      }
    } on DioError catch (e) {
      stateResponse = StateResponse(message: e.message, baseStatus: false);
    }

    return stateResponse;
  }

  Future<NotificationResponse> notification() async {
    late NotificationResponse notificationResponse;
    try {
      final response = await _networkProvider.call(
          // body: encode,
          queryParams: {"platform": "TREASURY"},
          path: AppConfig.notification,
          method: RequestMethod.get);

      if (response!.statusCode == 200) {
        notificationResponse =
            NotificationResponse.fromJson({"note": response.data});
        notificationResponse.baseStatus = true;
      } else {
        notificationResponse = NotificationResponse(baseStatus: false);
      }
    } on DioError catch (e) {
      notificationResponse =
          NotificationResponse(message: e.message, baseStatus: false);
    }

    return notificationResponse;
  }

  Future<BaseResponse> markAsRead(int id) async {
    late BaseResponse baseResponse;
    try {
      final response = await _networkProvider.call(
          // body: encode,
          path: AppConfig.notificationById(id),
          method: RequestMethod.get);

      if (response!.statusCode == 200) {
        baseResponse = BaseResponse(baseStatus: true, message: "success");
        baseResponse.baseStatus = true;
      } else {
        baseResponse = BaseResponse(baseStatus: false);
      }
    } on DioError catch (e) {
      baseResponse = BaseResponse(message: e.message, baseStatus: false);
    }

    return baseResponse;
  }

  Future<BvnResponse> bvn(BvnRequest e) async {
    late BvnResponse bvnResponse;
    try {
      final encode = jsonEncode(e.toJson());
      final response = await _networkProvider.call(
          body: encode, path: AppConfig.verifyBvn, method: RequestMethod.post);

      if (response!.statusCode == 200) {
        bvnResponse = BvnResponse.fromJson(response.data);
        bvnResponse.success = true;
      }
    } on DioError catch (e) {
      bvnResponse = BvnResponse(message: e.message, success: false);
    }

    return bvnResponse;
  }

  Future<BaseResponse> logout() async {
    late BaseResponse baseResponse;
    try {
      final response = await _networkProvider.call(
          path: AppConfig.logout, method: RequestMethod.post);

      if (response!.statusCode == 200) {
        baseResponse = BaseResponse(message: "");

        baseResponse.baseStatus = true;
      } else {
        baseResponse =
            BaseResponse(message: "Something went wrong", baseStatus: false);
      }
    } on DioError catch (e) {
      baseResponse = BaseResponse(message: e.message, baseStatus: false);
    }

    return baseResponse;
  }
}
