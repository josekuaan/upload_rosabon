import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rosabon/model/request_model/withdrawal_request.dart';
import 'package:rosabon/model/response_models/base_response.dart';
import 'package:rosabon/model/response_models/bonus_response.dart';
import 'package:rosabon/model/response_models/deposit_history_response.dart';
import 'package:rosabon/model/response_models/myreferal_response.dart';
import 'package:rosabon/model/response_models/transaction_response.dart';
import 'package:rosabon/model/response_models/wallet_response.dart';
import 'package:rosabon/model/response_models/walletplantransfer_request.dart';
import 'package:rosabon/model/response_models/withdrawalReason_response.dart';
import 'package:rosabon/newtwork/network_config/app_config.dart';
import 'package:rosabon/newtwork/network_provider/network_provider.dart';

class WalletRepository {
  final NetworkProvider _networkProvider = NetworkProvider();

  Future<WithdrawalReasonResponse> withdrawalReason() async {
    WithdrawalReasonResponse withdrawalReasonResponse;
    try {
      var res = await _networkProvider.call(
          path: AppConfig.withdrawalReason, method: RequestMethod.get);

      if (res!.statusCode == 200) {
        withdrawalReasonResponse = WithdrawalReasonResponse.fromJson(
            {"withdrawalReason": res.data["data"]["body"]});
        withdrawalReasonResponse.baseStatus = true;
      } else {
        withdrawalReasonResponse =
            WithdrawalReasonResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      withdrawalReasonResponse =
          WithdrawalReasonResponse(message: e.message, baseStatus: false);
    }
    return withdrawalReasonResponse;
  }

  Future<BaseResponse> wallettransfer(
      WalletPlanTransferRequest walletPlanTransferRequest) async {
    BaseResponse baseResponse;
    try {
      final encode = jsonEncode(walletPlanTransferRequest.toJson());
      var res = await _networkProvider.call(
          body: encode,
          path: AppConfig.wallettransfer,
          method: RequestMethod.post);

      if (res!.statusCode == 200) {
        baseResponse = BaseResponse(message: "Plan Transafer was Successfully");
        baseResponse.baseStatus = true;
      } else {
        baseResponse = BaseResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      baseResponse = BaseResponse(message: e.message, baseStatus: false);
    }
    return baseResponse;
  }

  Future<BaseResponse> withdrawal(WithdrawalRequest withdrawalRequest) async {
    BaseResponse baseResponse;
    try {
      final encode = jsonEncode(withdrawalRequest.toJson());
      var res = await _networkProvider.call(
          body: encode,
          path: AppConfig.requestwithdrawal,
          method: RequestMethod.post);

      if (res!.statusCode == 200) {
        baseResponse =
            BaseResponse(message: "Withdrawal Requested Successfully");
        baseResponse.baseStatus = true;
      } else {
        baseResponse = BaseResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      baseResponse = BaseResponse(message: e.message, baseStatus: false);
    }
    return baseResponse;
  }

  Future<TransactionResponse> fetchWalletTransactions() async {
    TransactionResponse transactionResponse;
    try {
      var res = await _networkProvider.call(
          path: AppConfig.getWallet, method: RequestMethod.get);

      if (res!.statusCode == 200) {
        transactionResponse =
            TransactionResponse.fromJson({"transaction": res.data["entities"]});
        transactionResponse.baseStatus = true;
      } else {
        transactionResponse =
            TransactionResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      transactionResponse =
          TransactionResponse(message: e.message, baseStatus: false);
    }
    return transactionResponse;
  }

  Future<DepositHistoryResponse> fetchDepositTransctions() async {
    DepositHistoryResponse depositHistoryResponse;
    try {
      var res = await _networkProvider.call(
        path: AppConfig.mydeposit,
        method: RequestMethod.get,
      );

      if (res!.statusCode == 200) {
        depositHistoryResponse =
            DepositHistoryResponse.fromJson({"deposit": res.data["entities"]});
        depositHistoryResponse.baseStatus = true;
      } else {
        depositHistoryResponse =
            DepositHistoryResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      depositHistoryResponse =
          DepositHistoryResponse(message: e.message, baseStatus: false);
    }
    return depositHistoryResponse;
  }

  Future<WalletResponse> fetchWalletBalance() async {
    WalletResponse walletResponse;
    try {
      var res = await _networkProvider.call(
          path: AppConfig.walletBalance, method: RequestMethod.get);

      if (res!.statusCode == 200) {
        walletResponse = WalletResponse.fromJson(res.data);
        walletResponse.baseStatus = true;
      } else {
        walletResponse = WalletResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      walletResponse = WalletResponse(message: e.message, baseStatus: false);
    }
    return walletResponse;
  }

  Future<BonuResponse> referralsactivities() async {
    BonuResponse bonuResponse;
    try {
      var res = await _networkProvider.call(
          path: AppConfig.referralsactivities, method: RequestMethod.get);

      if (res!.statusCode == 200) {
        bonuResponse = BonuResponse.fromJson({"bonus": res.data["entities"]});
        bonuResponse.baseStatus = true;
      } else {
        bonuResponse = BonuResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      bonuResponse = BonuResponse(message: e.message, baseStatus: false);
    }
    return bonuResponse;
  }

  Future<BonuResponse> threshold() async {
    BonuResponse bonuResponse;
    try {
      var res = await _networkProvider.call(
          path: AppConfig.threshold, method: RequestMethod.get);

      if (res!.statusCode == 200) {
        bonuResponse = BonuResponse.fromJson({"bonus": res.data["entities"]});
        bonuResponse.baseStatus = true;
      } else {
        bonuResponse = BonuResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      bonuResponse = BonuResponse(message: e.message, baseStatus: false);
    }
    return bonuResponse;
  }

  Future<BonuResponse> specialactivities() async {
    BonuResponse bonuResponse;
    try {
      var res = await _networkProvider.call(
          path: AppConfig.specialearnings, method: RequestMethod.get);

      if (res!.statusCode == 200) {
        bonuResponse = BonuResponse.fromJson({"bonus": res.data["entities"]});
        bonuResponse.baseStatus = true;
      } else {
        bonuResponse = BonuResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      bonuResponse = BonuResponse(message: e.message, baseStatus: false);
    }
    return bonuResponse;
  }

  Future<MyreferalResponse> myreferrals() async {
    MyreferalResponse myreferalResponse;
    try {
      var res = await _networkProvider.call(
          path: AppConfig.myreferrals, method: RequestMethod.get);

      if (res!.statusCode == 200) {
        myreferalResponse =
            MyreferalResponse.fromJson({"referals": res.data["entities"]});
        myreferalResponse.baseStatus = true;
      } else {
        myreferalResponse = MyreferalResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      myreferalResponse =
          MyreferalResponse(message: e.message, baseStatus: false);
    }
    return myreferalResponse;
  }

  Future<BaseResponse> pokeUser(int id) async {
    BaseResponse baseResponse;
    try {
      var res = await _networkProvider.call(
          path: AppConfig.pokeUser(id), method: RequestMethod.post);

      if (res!.statusCode == 200) {
        baseResponse = BaseResponse(message: "Plan Transafer was Successfully");
        baseResponse.baseStatus = true;
      } else {
        baseResponse = BaseResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      baseResponse = BaseResponse(message: e.message, baseStatus: false);
    }
    return baseResponse;
  }

  Future<BaseResponse> redeemspecialBonus() async {
    BaseResponse baseResponse;
    try {
      var res = await _networkProvider.call(
          path: AppConfig.redeemspecialBonus, method: RequestMethod.post);

      if (res!.statusCode == 200) {
        baseResponse =
            BaseResponse(message: "You have Successfully Redeemed your Bonus");
        baseResponse.baseStatus = true;
      } else {
        baseResponse = BaseResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      baseResponse = BaseResponse(message: e.message, baseStatus: false);
    }
    return baseResponse;
  }

  Future<BaseResponse> totalearning() async {
    BaseResponse baseResponse;
    try {
      var res = await _networkProvider.call(
          path: AppConfig.totalearning, method: RequestMethod.get);

      if (res!.statusCode == 200) {
        baseResponse = BaseResponse(message: res.data.toString());
        baseResponse.baseStatus = true;
      } else {
        baseResponse = BaseResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      baseResponse = BaseResponse(message: e.message, baseStatus: false);
    }
    return baseResponse;
  }

  Future<BaseResponse> getTotalSpecialEarning() async {
    BaseResponse baseResponse;
    try {
      var res = await _networkProvider.call(
          path: AppConfig.getTotalSpecialEarning, method: RequestMethod.get);

      if (res!.statusCode == 200) {
        baseResponse = BaseResponse(message: res.data.toString());
        baseResponse.baseStatus = true;
      } else {
        baseResponse = BaseResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      baseResponse = BaseResponse(message: e.message, baseStatus: false);
    }
    return baseResponse;
  }

  Future<BaseResponse> redeembonus() async {
    BaseResponse baseResponse;
    try {
      var res = await _networkProvider.call(
          path: AppConfig.redeembonus, method: RequestMethod.post);

      if (res!.statusCode == 200) {
        baseResponse =
            BaseResponse(message: "You have Successfully Redeemed your Bonus");
        baseResponse.baseStatus = true;
      } else {
        baseResponse = BaseResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      baseResponse = BaseResponse(message: e.message, baseStatus: false);
    }
    return baseResponse;
  }
}
