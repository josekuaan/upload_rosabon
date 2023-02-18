import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rosabon/model/request_model/company_details_update_request.dart';
import 'package:rosabon/model/response_models/base_response.dart';
import 'package:rosabon/model/response_models/identity_response.dart';
import 'package:rosabon/model/response_models/user_response.dart';
import 'package:rosabon/newtwork/network_config/app_config.dart';
import 'package:rosabon/newtwork/network_provider/network_provider.dart';

class ProfileRepository {
  final NetworkProvider _networkProvider = NetworkProvider();

  Future<BaseResponse> companyUpdate(
      CompanyDetailsUpdateequest companyDetailsUpdateequest) async {
    late BaseResponse baseResponse;
    UserResponse userResponse;
    try {
      final encode = jsonEncode(companyDetailsUpdateequest.toJson());
      final response = await _networkProvider.call(
          body: encode,
          path: AppConfig.companyDetails,
          method: RequestMethod.put);
      print(response!.statusCode);
      if (response.statusCode == 200) {
        userResponse = UserResponse.fromJson(response.data);
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

  Future<IdentityReponse> identificationType() async {
    late IdentityReponse identityReponse;
    try {
      var res = await _networkProvider.call(
          queryParams: {"status": "ACTIVE"},
          path: AppConfig.identificationType,
          method: RequestMethod.get);

      if (res!.statusCode == 200) {
        identityReponse = IdentityReponse.fromJson({"ids": res.data});
        identityReponse.baseStatus = true;
      }
    } on DioError catch (e) {
      identityReponse = IdentityReponse(message: e.message, baseStatus: false);
    }
    return identityReponse;
  }

  Future<BaseResponse> generalOtp(String message) async {
    BaseResponse baseResponse;
    try {
      var res = await _networkProvider.call(
        path: AppConfig.generalOtp,
        body: {"message": "", "subject": message},
        method: RequestMethod.post,
      );

      if (res!.statusCode == 200) {
        baseResponse = BaseResponse(message: "success", baseStatus: true);
      } else {
        baseResponse = BaseResponse(message: "Otp failed", baseStatus: false);
      }
    } on DioError catch (e) {
      baseResponse = BaseResponse(message: e.message, baseStatus: false);
    }

    return baseResponse;
  }

  Future<BaseResponse> individualOtp() async {
    BaseResponse baseResponse;
    try {
      var res = await _networkProvider.call(
        path: AppConfig.individualOtp,
        method: RequestMethod.get,
      );

      if (res!.statusCode == 200) {
        baseResponse = BaseResponse(message: "success", baseStatus: true);
      } else {
        baseResponse = BaseResponse(message: "Otp failed", baseStatus: false);
      }
    } on DioError catch (e) {
      baseResponse = BaseResponse(message: e.message, baseStatus: false);
    }

    return baseResponse;
  }
}
