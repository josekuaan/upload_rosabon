import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rosabon/model/request_model/bank_request.dart';
import 'package:rosabon/model/request_model/personal_information_request.dart';
import 'package:rosabon/model/request_model/verify_account_request.dart';
import 'package:rosabon/model/response_models/accountnumber_response.dart';
import 'package:rosabon/model/response_models/bank_response.dart';
import 'package:rosabon/model/response_models/base_response.dart';
import 'package:rosabon/model/response_models/employment_response.dart';
import 'package:rosabon/model/response_models/update_account_response.dart';

import 'package:rosabon/model/response_models/verifyaccount_response.dart';
import 'package:rosabon/model/response_models/virtualacount_response.dart';
import 'package:rosabon/newtwork/network_config/app_config.dart';
import 'package:rosabon/newtwork/network_provider/network_provider.dart';
import 'package:rosabon/session_manager/session_manager.dart';

class GeneralRepository {
  final NetworkProvider _networkProvider = NetworkProvider();
  final SessionManager _sessionManager = SessionManager();

  Future<BanksResponse> banks() async {
    BanksResponse banksResponse;
    try {
      var res = await _networkProvider.call(
          path: AppConfig.banks, method: RequestMethod.get);

      if (res!.statusCode == 200) {
        banksResponse = BanksResponse.fromJson(res.data);
        banksResponse.success = true;
      } else {
        banksResponse = BanksResponse(message: "", success: false);
      }
    } on DioError catch (e) {
      banksResponse = BanksResponse(message: e.message, success: false);
    }
    return banksResponse;
  }

  Future<BankAccountResponse> fetchBankAccount() async {
    BankAccountResponse bankAccountResponse;
    try {
      var res = await _networkProvider.call(
          path: AppConfig.bankaccount, method: RequestMethod.get);

      if (res!.statusCode == 200) {
        bankAccountResponse = BankAccountResponse.fromJson(res.data);
        bankAccountResponse.baseStatus = true;
      } else {
        bankAccountResponse =
            BankAccountResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      bankAccountResponse =
          BankAccountResponse(message: e.message, baseStatus: false);
    }
    return bankAccountResponse;
  }

  Future<VirtualAccountResponse> viewbankdetails(int planId) async {
    VirtualAccountResponse virtualAccountResponse;
    try {
      var res = await _networkProvider.call(
          queryParams: {"planId": planId},
          path: AppConfig.viewbankdetails,
          method: RequestMethod.get);

      if (res!.statusCode == 200) {
        virtualAccountResponse = VirtualAccountResponse.fromJson(res.data);
        virtualAccountResponse.baseStatus = true;
      } else {
        virtualAccountResponse =
            VirtualAccountResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      virtualAccountResponse =
          VirtualAccountResponse(message: e.message, baseStatus: false);
    }
    return virtualAccountResponse;
  }

  Future<VirtualAccountResponse> virtualAccount(
      String planName, String action) async {
    VirtualAccountResponse virtualAccountResponse;
    try {
      var res = await _networkProvider.call(
          queryParams: action.isEmpty ? {"planName": planName} : {},
          path: action.isEmpty
              ? AppConfig.virtualdynamicaccount
              : AppConfig.virtualaccount,
          method: action.isEmpty ? RequestMethod.post : RequestMethod.get);

      if (res!.statusCode == 200) {
        virtualAccountResponse = VirtualAccountResponse.fromJson(res.data);
        virtualAccountResponse.baseStatus = true;
      } else {
        virtualAccountResponse =
            VirtualAccountResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      virtualAccountResponse =
          VirtualAccountResponse(message: e.message, baseStatus: false);
    }
    return virtualAccountResponse;
  }

  Future<BaseResponse> otpCode(String val) async {
    BaseResponse baseResponse;
    try {
      var res = await _networkProvider.call(
          // body: {},
          path: val.isNotEmpty
              ? AppConfig.companyOtp
              : AppConfig.bankAccountSendOtp,
          method: RequestMethod.get);

      if (res!.statusCode == 200) {
        _sessionManager.otpVal = res.data["data"];
        baseResponse = BaseResponse(message: "", baseStatus: true);
      } else {
        baseResponse = BaseResponse(message: "Otp failed", baseStatus: false);
      }
    } on DioError catch (e) {
      baseResponse = BaseResponse(message: e.message, baseStatus: false);
    }
    return baseResponse;
  }

  Future<BaseResponse> postOtpCode() async {
    BaseResponse baseResponse;
    try {
      var res = await _networkProvider.call(
          // body: {},
          path: AppConfig.bankAccountSendOtp,
          method: RequestMethod.get);

      if (res!.statusCode == 200) {
        SessionManager().otpVal = res.data["data"];
        baseResponse = BaseResponse(message: "", baseStatus: true);
      } else {
        baseResponse = BaseResponse(message: "Otp failed", baseStatus: false);
      }
    } on DioError catch (e) {
      baseResponse = BaseResponse(message: e.message, baseStatus: false);
    }
    return baseResponse;
  }

  Future<BaseResponse> validateOtp(String otp) async {
    BaseResponse baseResponse;
    try {
      var res = await _networkProvider.call(
          path: AppConfig.validateOtp(otp), method: RequestMethod.post);

      if (res!.statusCode == 200) {
        baseResponse = BaseResponse(message: "", baseStatus: true);
      } else {
        baseResponse =
            BaseResponse(message: "Validation failed", baseStatus: false);
      }
    } on DioError catch (e) {
      baseResponse = BaseResponse(message: e.message, baseStatus: false);
    }
    return baseResponse;
  }

  Future<BaseResponse> validatePhone(String phoneNumber) async {
    BaseResponse baseResponse;
    try {
      var res = await _networkProvider.call(
          // queryParams: {"reciptent": P},
          path: AppConfig.validatePhone(phoneNumber),
          method: RequestMethod.get);

      if (res!.statusCode == 200) {
        baseResponse = BaseResponse(message: "", baseStatus: true);
      } else {
        baseResponse =
            BaseResponse(message: "Validation failed", baseStatus: false);
      }
    } on DioError catch (e) {
      baseResponse = BaseResponse(message: e.message, baseStatus: false);
    }
    return baseResponse;
  }

  Future<VerifyAccountResponse> verifyBank(
      VerifyAccountRequest verifyAccountRequest) async {
    VerifyAccountResponse verifyAccountResponse;
    try {
      final encode = jsonEncode(verifyAccountRequest.toJson());
      var res = await _networkProvider.call(
          body: encode,
          path: AppConfig.verifyAccount,
          method: RequestMethod.post);

      if (res!.statusCode == 200) {
        verifyAccountResponse =
            VerifyAccountResponse.fromJson({"account": res.data["data"]});
        verifyAccountResponse.baseStatus = true;
      } else {
        verifyAccountResponse =
            VerifyAccountResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      verifyAccountResponse =
          VerifyAccountResponse(message: e.message, baseStatus: false);
    }
    return verifyAccountResponse;
  }

  Future<UpdateAccountResponse> updateBankAccount(
      BankRequest bankRequest) async {
    UpdateAccountResponse updateAccountResponse;
    try {
      final encode = jsonEncode(bankRequest.toJson());
      var res = await _networkProvider.call(
          body: encode,
          path: AppConfig.updateBankAccount,
          method: RequestMethod.put);

      if (res!.statusCode == 200) {
        updateAccountResponse = UpdateAccountResponse.fromJson(res.data);
        updateAccountResponse.baseStatus = true;
      } else {
        updateAccountResponse =
            UpdateAccountResponse(message: "", baseStatus: false);
      }
    } catch (e) {
      print(e);
      updateAccountResponse =
          UpdateAccountResponse(message: e, baseStatus: false);
    }
    return updateAccountResponse;
  }

  Future<BanksResponse> bankAccountOtp() async {
    BanksResponse banksResponse;
    try {
      var res = await _networkProvider.call(
          body: {},
          path: AppConfig.bankAccountSendOtp,
          method: RequestMethod.post);

      if (res!.statusCode == 200) {
        banksResponse = BanksResponse.fromJson(res.data);
        banksResponse.success = true;
      } else {
        banksResponse = BanksResponse(message: "", success: false);
      }
    } on DioError catch (e) {
      banksResponse = BanksResponse(message: e.message, success: false);
    }
    return banksResponse;
  }

  Future<EmploymentResponse> saveNextOfKin(
      PersonalInformationRequest nextOfKinRequest) async {
    EmploymentResponse employmentResponse;
    try {
      final encode = jsonEncode(nextOfKinRequest.toJson());
      var res = await _networkProvider.call(
          body: encode,
          path: AppConfig.individualPerson,
          method: RequestMethod.put);

      if (res!.statusCode == 200) {
        print(res.data["nokDetail"]);
        employmentResponse = EmploymentResponse.fromJson(res.data);
        employmentResponse.baseStatus = true;
      } else {
        employmentResponse = EmploymentResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      employmentResponse =
          EmploymentResponse(message: e.message, baseStatus: false);
    }
    return employmentResponse;
  }

  Future<EmploymentResponse> employmentDetails(
      PersonalInformationRequest nextOfKinRequest) async {
    EmploymentResponse employmentResponse;
    try {
      final encode = jsonEncode(nextOfKinRequest.toJson());
      var res = await _networkProvider.call(
          body: encode,
          path: AppConfig.individualPerson,
          method: RequestMethod.put);

      if (res!.statusCode == 200) {
        employmentResponse = EmploymentResponse.fromJson(res.data);
        employmentResponse.baseStatus = true;
      } else {
        employmentResponse = EmploymentResponse(message: "", baseStatus: false);
      }
    } catch (e) {
      employmentResponse =
          EmploymentResponse(message: e.toString(), baseStatus: false);
    }
    return employmentResponse;
  }
}
