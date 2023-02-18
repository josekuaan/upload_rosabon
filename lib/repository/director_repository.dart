import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rosabon/model/response_models/base_response.dart';
// import 'package:http/http.dart';

import 'package:rosabon/model/response_models/director_response.dart';
import 'package:rosabon/newtwork/network_config/app_config.dart';
import 'package:rosabon/newtwork/network_provider/network_provider.dart';
import 'package:rosabon/session_manager/session_manager.dart';

class DirectorRepository {
  final NetworkProvider _networkProvider = NetworkProvider();

  Future<BaseResponse> sendOtpDirectors() async {
    BaseResponse baseResponse;
    try {
      var res = await _networkProvider.call(
        path: AppConfig.directorOtp,
        method: RequestMethod.post,
      );

      if (res!.statusCode == 200) {
        SessionManager().otpVal = res.data["data"];
        baseResponse =
            BaseResponse(message: res.data["data"], baseStatus: true);
      } else {
        baseResponse = BaseResponse(message: "Otp failed", baseStatus: false);
      }
    } on DioError catch (e) {
      baseResponse = BaseResponse(message: e.message, baseStatus: false);
    }

    return baseResponse;
  }

  Future<DirectorResponse> fetchDirectors() async {
    DirectorResponse directorResponse;
    try {
      var res = await _networkProvider.call(
        path: AppConfig.fetchDirector,
        method: RequestMethod.get,
      );

      if (res!.statusCode == 200) {
        directorResponse = DirectorResponse.fromJson({"data": res.data});

        directorResponse.baseStatus = true;
      } else {
        directorResponse = DirectorResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      directorResponse = DirectorResponse(message: e, baseStatus: false);
    }
    return directorResponse;
  }

  Future<DirectorResponse> saveDirector(
      List<Map<String, dynamic>> directorRequest) async {
    DirectorResponse directorResponse;
    try {
      String json = jsonEncode(directorRequest);

      var res = await _networkProvider.call(
          body: json,
          path: AppConfig.directorDetails,
          method: RequestMethod.put,
          queryParams: {"otp": SessionManager().otpVal});

      if (res!.statusCode == 200) {
        directorResponse = DirectorResponse.fromJson(res.data);
        directorResponse.baseStatus = true;
      } else {
        directorResponse = DirectorResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      directorResponse = DirectorResponse(message: e, baseStatus: false);
    }
    return directorResponse;
  }

  Future<BaseResponse> deleteDirector(int id) async {
    BaseResponse baseResponse;
    // late BaseResponse baseResponse;
    try {
      final res = await _networkProvider.call(
          // body: encode,
          path: AppConfig.deleteDirector(id),
          method: RequestMethod.delete);
      if (res!.statusCode == 200) {
        baseResponse = BaseResponse(message: "", baseStatus: true);
      } else {
        baseResponse = BaseResponse(message: '', baseStatus: false);
      }
    } on DioError catch (e) {
      baseResponse = BaseResponse(message: e.message, baseStatus: false);

      // baseResponse = BaseResponse(message: e.message, baseStatus: false);
    }
    return baseResponse;
    // return;
  }
}
