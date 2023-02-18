import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rosabon/newtwork/model/api_error_model.dart';

class ApiError {
  late String errorDescription;
  ApiErrorModel? apiErrorModel;

  ApiError({required this.errorDescription});

  ApiError.fromDio(Object dioError) {
    _handleError(dioError);
  }

  void _handleError(Object error) {
    print(error);
    if (error is DioError) {
      print(error);
      var dioError = error;
      switch (dioError.type) {
        case DioErrorType.cancel:
          errorDescription = "Request was cancelled";
          break;
        case DioErrorType.connectTimeout:
          print("am hereeeeeeeeeeeee");
          errorDescription = "Connection timeout";
          break;
        case DioErrorType.other:
          errorDescription = "Connection failed due to internet connection";
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = "Receive timeout in connection";
          break;
        case DioErrorType.response:
          if (dioError.response!.statusCode == 401) {
            errorDescription = error.response!.data["message"];
            return;
          }
          if (dioError.response!.statusCode == 500) {
            errorDescription = 'Session timeout';
          }
          // if (dioError.response!.data["status"] == 400) {
          //   errorDescription = error.response!.data["message"];

          //   return;
          // }
          else if (dioError.response!.statusCode == 400) {
            errorDescription = extractDescriptionFromResponse(error.response);
          }

          if (dioError.response!.statusCode == 428) {
            errorDescription = error.response!.data["message"];
            return;
          } else if (dioError.response!.statusCode == 500) {
            errorDescription = 'A Server Error Occurred';
          } else if (dioError.response!.statusCode == 404) {
            errorDescription = dioError.response!.data["message"];
          } else if (dioError.response!.statusCode == 400) {
            errorDescription = dioError.response!.data["message"];
          } else if (dioError.response!.statusCode == 409) {
            errorDescription = dioError.response!.data["message"];
          } else {
            errorDescription = 'Something went wrong.';
          }
          break;
        case DioErrorType.sendTimeout:
          errorDescription = "Send timeout in connection";
          break;
      }
    } else {
      errorDescription = "An unexpected error occurred";
    }
  }

  String extractDescriptionFromResponse(Response? response) {
    var message = '';
    var data = response!.data;

    try {
      if (response.data != null) {
        message = data['message'];
      } else {
        message = response.statusMessage!;
      }
    } catch (error) {
      message = response.statusMessage ?? error.toString();
    }
    return message;
  }

  @override
  String toString() => errorDescription;
}


// [12:48 PM, 10/29/2022] +234 803 097 9737: WALLET_TO_BANK_ACCOUNT_FUNDING,
//         WALLET_FUNDING_BY_ROSABON_ADMIN,
//         WALLET_FUNDING_BY_CARD,
//         FUND_REVERSAL_TO_WALLET,
//         WALLET_TO_PLAN_FUNDING,
//         WALLET_FUNDING_BY_REFERRAL,
//         BANK_ACCOUNT_TO_WALLET_FUNDING,
//         WALLET_FUNDING_BY_CREDIT_WALLET,
//         PLAN_TO_WALLET_FUNDING
// [12:49 PM, 10/29/2022] +234 803 097 9737: PLAN_TO_WALLET_FUNDING
// WALLET_FUNDING_BY_CREDIT_WALLET,
//  BANK_ACCOUNT_TO_WALLET_FUNDING,