import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rosabon/model/request_model/initPayment_request.dart';
import 'package:rosabon/model/request_model/paymentInit.dart';
import 'package:rosabon/model/request_model/plan_request.dart';
import 'package:rosabon/model/request_model/rollover_request.dart';
import 'package:rosabon/model/request_model/topup_request.dart';
import 'package:rosabon/model/request_model/transfer_request.dart';
import 'package:rosabon/model/request_model/withdraw_plan_request.dart';
import 'package:rosabon/model/response_models/base_response.dart';
import 'package:rosabon/model/response_models/create_plan_response.dart';
import 'package:rosabon/model/response_models/init_transfer.dart';
import 'package:rosabon/model/response_models/penal_response.dart';
import 'package:rosabon/model/response_models/plan_history_response.dart';
import 'package:rosabon/model/response_models/product_response.dart';
import 'package:rosabon/model/response_models/withholding_tax_response.dart';
import 'package:rosabon/model/response_models/exchange_rate.dart';
import 'package:rosabon/model/response_models/investmentrate_response.dart';
import 'package:rosabon/model/response_models/plan_response.dart';
import 'package:rosabon/model/response_models/product_category_response.dart';
import 'package:rosabon/newtwork/network_config/app_config.dart';
import 'package:rosabon/newtwork/network_provider/network_provider.dart';
import 'package:rosabon/session_manager/session_manager.dart';

class ProductRepository {
  SessionManager sessionManager = SessionManager();
  final NetworkProvider _networkProvider = NetworkProvider();

  Future<Item> getProductById(int id) async {
    late Item item;
    try {
      var res = await _networkProvider.call(
          queryParams: {"status": "ACTIVE"},
          path: AppConfig.getProductById(id),
          method: RequestMethod.get);

      if (res!.statusCode == 200) {
        item = Item.fromJson(res.data["data"]["body"]);
        item.baseStatus = true;
      } else {
        item = Item(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      item = Item(message: e.message, baseStatus: false);
    }
    return item;
  }

  Future<ProductCategoryResponse> getProducts() async {
    ProductCategoryResponse productCategoryResponse;
    try {
      var res = await _networkProvider.call(
          queryParams: {"status": "ACTIVE"},
          path: AppConfig.products,
          method: RequestMethod.get);

      if (res!.statusCode == 200) {
        productCategoryResponse = ProductCategoryResponse.fromJson(
            {"Product": res.data["data"]["body"]});

        productCategoryResponse.baseStatus = true;
      } else {
        productCategoryResponse =
            ProductCategoryResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      productCategoryResponse =
          ProductCategoryResponse(message: e.message, baseStatus: false);
    }
    return productCategoryResponse;
  }

  Future<ProductResponse> allproducts() async {
    ProductResponse productResponse;
    try {
      var res = await _networkProvider.call(
          queryParams: {"status": "ACTIVE"},
          path: AppConfig.allproducts,
          method: RequestMethod.get);

      if (res!.statusCode == 200) {
        productResponse =
            ProductResponse.fromJson({"items": res.data["data"]["body"]});
        productResponse.baseStatus = true;
      } else {
        productResponse = ProductResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      productResponse = ProductResponse(message: e.message, baseStatus: false);
    }
    return productResponse;
  }

  Future<InvestmentRateResponse> investmentrate() async {
    InvestmentRateResponse investmentRateResponse;
    try {
      var res = await _networkProvider.call(
          // queryParams: {"status": "ACTIVE"},
          path: AppConfig.investmentrate,
          method: RequestMethod.get);

      if (res!.statusCode == 200) {
        investmentRateResponse =
            InvestmentRateResponse.fromJson({"body": res.data["data"]["body"]});

        investmentRateResponse.baseStatus = true;
      } else {
        investmentRateResponse =
            InvestmentRateResponse(message: "", baseStatus: false);
      }
    } catch (e) {
      print(e);
      investmentRateResponse =
          InvestmentRateResponse(message: e, baseStatus: false);
    }
    return investmentRateResponse;
  }

  Future<WithholdingTaxResponse> withholdingrate() async {
    WithholdingTaxResponse withholdingTaxResponse;
    try {
      var res = await _networkProvider.call(
          queryParams: {"status": "ACTIVE"},
          path: AppConfig.withholdingrate,
          method: RequestMethod.get);

      if (res!.statusCode == 200) {
        withholdingTaxResponse =
            WithholdingTaxResponse.fromJson(res.data["data"]["body"][0]);
        withholdingTaxResponse.baseStatus = true;
      } else {
        withholdingTaxResponse =
            WithholdingTaxResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      withholdingTaxResponse =
          WithholdingTaxResponse(message: e.message, baseStatus: false);
    }
    return withholdingTaxResponse;
  }

  Future<ExchangeResponse> getExchangeRate(String currency) async {
    ExchangeResponse exchangeResponse;
    try {
      var res = await _networkProvider.call(
          queryParams: {"currency": currency},
          path: AppConfig.trexchangerate,
          method: RequestMethod.get);

      if (res!.statusCode == 200) {
        exchangeResponse =
            ExchangeResponse.fromJson({"body": res.data["data"]["body"]});
        exchangeResponse.baseStatus = true;
      } else {
        exchangeResponse = ExchangeResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      exchangeResponse =
          ExchangeResponse(message: e.message, baseStatus: false);
    }
    return exchangeResponse;
  }

  Future<PenalResponse> penalcharge() async {
    PenalResponse penalResponse;
    try {
      var res = await _networkProvider.call(
          // queryParams: {"currency": currency},
          path: AppConfig.penalcharge,
          method: RequestMethod.get);

      if (res!.statusCode == 200) {
        penalResponse =
            PenalResponse.fromJson({"penal": res.data["data"]["body"]});
        penalResponse.baseStatus = true;
      } else {
        penalResponse = PenalResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      penalResponse = PenalResponse(message: e.message, baseStatus: false);
    }
    return penalResponse;
  }

  Future<CreatePlanResponse> createPlan(PlanRequest planRequest) async {
    CreatePlanResponse createPlanResponse;

    try {
      final encoded = jsonEncode(planRequest.toJson());

      var res = await _networkProvider.call(
          body: encoded,
          path: AppConfig.createPlan,
          method: RequestMethod.post);

      if (res!.statusCode == 200) {
        createPlanResponse =
            CreatePlanResponse.fromJson({"plans": res.data["data"]["body"]});
        createPlanResponse.baseStatus = true;
      } else {
        createPlanResponse = CreatePlanResponse(message: "", baseStatus: false);
      }
    } catch (e) {
      print(e);
      createPlanResponse = CreatePlanResponse(message: e, baseStatus: false);
    }
    return createPlanResponse;
  }

  Future<CreatePlanResponse> updatePlan(PlanRequest planRequest, int id) async {
    CreatePlanResponse createPlanResponse;

    try {
      final encoded = jsonEncode(planRequest.toJson());

      var res = await _networkProvider.call(
          body: encoded,
          path: AppConfig.updatePlan(id),
          method: RequestMethod.put);

      if (res!.statusCode == 200) {
        createPlanResponse =
            CreatePlanResponse(baseStatus: true, message: "success");
      } else {
        createPlanResponse = CreatePlanResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      createPlanResponse =
          CreatePlanResponse(message: e.message, baseStatus: false);
    }
    return createPlanResponse;
  }

  Future<PlanResponse> planActions(TopUpRequest topUpRequest) async {
    PlanResponse planResponse;
    try {
      final encoded = jsonEncode(topUpRequest.toJson());

      var res = await _networkProvider.call(
          body: topUpRequest.planAction == "PAY_WITH_CARD" ? {} : encoded,
          queryParams: topUpRequest.planAction == "PAY_WITH_CARD"
              ? {"planId": topUpRequest.plan}
              : {},
          path: topUpRequest.planAction == "PAY_WITH_CARD"
              ? AppConfig.paywithcard
              : AppConfig.planAction,
          method: topUpRequest.planAction == "PAY_WITH_CARD"
              ? RequestMethod.get
              : RequestMethod.post);

      if (res!.statusCode == 200) {
        planResponse = PlanResponse(baseStatus: true, message: "success");
      } else {
        planResponse = PlanResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      planResponse = PlanResponse(message: e.message, baseStatus: false);
    }
    return planResponse;
  }

  Future<PlanResponse> rolloverPlan(RolloverResquest rolloverResquest) async {
    PlanResponse planResponse;
    try {
      final encoded = jsonEncode(rolloverResquest.toJson());

      var res = await _networkProvider.call(
          body: encoded,
          path: AppConfig.planAction,
          method: RequestMethod.post);

      if (res!.statusCode == 200) {
        planResponse = PlanResponse(baseStatus: true, message: "success");
      } else {
        planResponse = PlanResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      planResponse = PlanResponse(message: e.message, baseStatus: false);
    }
    return planResponse;
  }

  Future<PlanResponse> withdrawPlan(
      WithdrawPlanRequest withdrawPlanRequest) async {
    PlanResponse planResponse;
    try {
      final encoded = jsonEncode(withdrawPlanRequest.toJson());

      var res = await _networkProvider.call(
          body: encoded,
          path: AppConfig.planAction,
          method: RequestMethod.post);

      if (res!.statusCode == 200) {
        if (res.data["statusCode"] == "EXPECTATION_FAILED") {
          planResponse =
              PlanResponse(message: res.data["message"], baseStatus: false);
        } else {
          planResponse = PlanResponse(baseStatus: true, message: "success");
        }
      } else {
        planResponse = PlanResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      planResponse = PlanResponse(message: e.message, baseStatus: false);
    }
    return planResponse;
  }

  Future<InitPlanTransfer> planTransfer(TransferRequest transferRequest) async {
    InitPlanTransfer initPlanTransfer;
    try {
      final encoded = jsonEncode(transferRequest.toJson());

      var res = await _networkProvider.call(
          body: encoded,
          path: AppConfig.planAction,
          method: RequestMethod.post);

      if (res!.statusCode == 200) {
        initPlanTransfer = InitPlanTransfer.fromJson(res.data);
        initPlanTransfer.baseStatus = true;
      } else {
        initPlanTransfer = InitPlanTransfer(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      initPlanTransfer =
          InitPlanTransfer(message: e.message, baseStatus: false);
    }
    return initPlanTransfer;
  }

  Future<PlanResponse> completePlan(int id) async {
    PlanResponse planResponse;
    try {
      var res = await _networkProvider.call(
          queryParams: {"id": id},
          path: AppConfig.completePlan,
          method: RequestMethod.post);

      if (res!.statusCode == 200) {
        planResponse = PlanResponse(baseStatus: true, message: "success");
      } else {
        planResponse = PlanResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      planResponse = PlanResponse(message: e.message, baseStatus: false);
    }
    return planResponse;
  }

  Future<PlanResponse> autoRollover(Map<String, dynamic> authorenewal) async {
    PlanResponse planResponse;
    try {
      final encoded = jsonEncode(authorenewal);

      var res = await _networkProvider.call(
          body: encoded,
          path: AppConfig.planAction,
          method: RequestMethod.post);

      if (res!.statusCode == 200) {
        planResponse = PlanResponse(baseStatus: true, message: "success");
      } else {
        planResponse = PlanResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      planResponse = PlanResponse(message: e.message, baseStatus: false);
    }
    return planResponse;
  }

  Future<PlanResponse> getPlan() async {
    PlanResponse planResponse;
    try {
      var res = await _networkProvider.call(
          path: AppConfig.createPlan, method: RequestMethod.get);

      if (res!.statusCode == 200) {
        planResponse =
            PlanResponse.fromJson({"plans": res.data["data"]["body"]});
        planResponse.baseStatus = true;
      } else {
        planResponse = PlanResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      planResponse = PlanResponse(message: e.message, baseStatus: false);
    }
    return planResponse;
  }

  Future<PlanResponse> fetchClosePlan() async {
    PlanResponse planResponse;
    try {
      var res = await _networkProvider.call(
          path: AppConfig.fetchClosePlan, method: RequestMethod.get);

      if (res!.statusCode == 200) {
        planResponse =
            PlanResponse.fromJson({"plans": res.data["data"]["body"]});

        planResponse.baseStatus = true;
      } else {
        planResponse = PlanResponse(message: "", baseStatus: false);
      }
    } catch (e) {
      print(e);
      planResponse = PlanResponse(message: e, baseStatus: false);
    }
    return planResponse;
  }

  Future<PlanResponse> eligibleplansfortransfer() async {
    PlanResponse planResponse;
    try {
      var res = await _networkProvider.call(
          path: AppConfig.eligibleplansfortransfer, method: RequestMethod.get);

      if (res!.statusCode == 200) {
        planResponse = PlanResponse.fromJson({"plans": res.data});
        planResponse.baseStatus = true;
      } else {
        planResponse = PlanResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      planResponse = PlanResponse(message: e.message, baseStatus: false);
    }
    return planResponse;
  }

  Future<PlanResponse> savePlan(TopUpRequest topUpRequest) async {
    PlanResponse planResponse;
    try {
      var jsonText = jsonEncode(topUpRequest.toJson());
      var res = await _networkProvider.call(
          body: jsonText,
          path: AppConfig.planAction,
          method: RequestMethod.post);

      if (res!.statusCode == 200) {
        planResponse = PlanResponse(message: "", baseStatus: true);
      } else {
        planResponse = PlanResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      planResponse = PlanResponse(message: e.message, baseStatus: false);
    }
    return planResponse;
  }

  Future<PlanHistoryResponse> planhistory(int id) async {
    PlanHistoryResponse planHistoryResponse;
    try {
      var res = await _networkProvider.call(
        path: AppConfig.planhistory(id),
        method: RequestMethod.get,
      );

      if (res!.statusCode == 200) {
        planHistoryResponse =
            PlanHistoryResponse.fromJson({"history": res.data["content"]});
        planHistoryResponse.baseStatus = true;
      } else {
        planHistoryResponse =
            PlanHistoryResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      planHistoryResponse =
          PlanHistoryResponse(message: e.message, baseStatus: false);
    }
    return planHistoryResponse;
  }

  Future<PlanResponse> deletePlan(int id) async {
    PlanResponse planResponse;
    try {
      var res = await _networkProvider.call(
          path: AppConfig.deletePlan(id), method: RequestMethod.delete);

      if (res!.statusCode == 200) {
        planResponse = PlanResponse.fromJson({"plans": res.data["content"]});
        planResponse.baseStatus = true;
      } else {
        planResponse = PlanResponse(message: "", baseStatus: false);
      }
    } on DioError catch (e) {
      planResponse = PlanResponse(message: e.message, baseStatus: false);
    }
    return planResponse;
  }

  Future<String> initPayment(InitPaymentRequest initPaymentRequest) async {
    String url = "";
    try {
      final encoded = jsonEncode(initPaymentRequest.toJson());
      var res = await _networkProvider.call(
          body: encoded,
          path: AppConfig.paymentInitialize,
          method: RequestMethod.post);

      if (res!.statusCode == 200) {
        url = res.data;
      }
    } catch (e) {
      rethrow;
    }
    return url;
  }

  Future<String> paymentInitialize(PaymentInit paymentInit) async {
    String url = "";
    try {
      final encoded = jsonEncode(paymentInit.toJson());
      var res = await _networkProvider.call(
          body: encoded,
          path: AppConfig.paymentInitialize,
          method: RequestMethod.post);

      if (res!.statusCode == 200) {
        url = res.data["transactionReference"];
      }
    } catch (e) {
      rethrow;
    }
    return url;
  }

  Future<BaseResponse> verifyPayment(String gateWay, String ref) async {
    late BaseResponse baseResponse;
    try {
      var res = await _networkProvider.call(
          path: AppConfig.verifyPayment(gateWay, ref),
          method: RequestMethod.get);

      if (res!.statusCode == 200) {
        baseResponse = BaseResponse(message: "", baseStatus: true);
      }
    } on DioError catch (e) {
      baseResponse = BaseResponse(message: e.message, baseStatus: false);
    }
    return baseResponse;
  }

  // Future<BaseResponse> paymentverification(String gateway, String ref) async {
  //   late BaseResponse baseResponse;
  //   try {
  //     var res = await _networkProvider.call(
  //         path: AppConfig.verifyPayment(gateway, ref),
  //         method: RequestMethod.get);

  //     if (res!.statusCode == 200) {
  //       // planResponse =
  //       //     PlanResponse.fromJson({"plans": res.data["data"]["body"]});
  //       // baseResponse.baseStatus = true;
  //     } else {
  //       baseResponse = BaseResponse(message: "", baseStatus: false);
  //     }
  //   } on DioError catch (e) {
  //     baseResponse = BaseResponse(message: e.message, baseStatus: false);
  //   }
  //   return baseResponse;
  // }
}
