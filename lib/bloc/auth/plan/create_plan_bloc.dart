import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rosabon/model/request_model/initPayment_request.dart';
import 'package:rosabon/model/request_model/paymentInit.dart';
import 'package:rosabon/model/request_model/plan_request.dart';
import 'package:rosabon/model/request_model/rollover_request.dart';
import 'package:rosabon/model/request_model/topup_request.dart';
import 'package:rosabon/model/request_model/transfer_request.dart';
import 'package:rosabon/model/request_model/withdraw_plan_request.dart';
import 'package:rosabon/model/response_models/base_response.dart';
import 'package:rosabon/model/response_models/create_plan_response.dart';

import 'package:rosabon/model/response_models/exchange_rate.dart';
import 'package:rosabon/model/response_models/init_transfer.dart';
import 'package:rosabon/model/response_models/investmentrate_response.dart';
import 'package:rosabon/model/response_models/penal_response.dart';
import 'package:rosabon/model/response_models/plan_history_response.dart';
import 'package:rosabon/model/response_models/plan_response.dart';
import 'package:rosabon/model/response_models/withholding_tax_response.dart';
import 'package:rosabon/repository/product_repository.dart';
import 'package:rosabon/session_manager/session_manager.dart';

part 'create_plan_event.dart';
part 'create_plan_state.dart';

class CreatePlanBloc extends Bloc<CreatePlanEvent, CreatePlanState> {
  final ProductRepository productRepository = ProductRepository();
  SessionManager sessionManager = SessionManager();
  List<String> planStatus = [];
  num totalWorth = 0;
  CreatePlanBloc() : super(CreatePlanInitial()) {
    on<CreatePlanEvent>((event, emit) async {
      if (event is FetchPlan) {
        await getPlan(event, emit);
      }
      if (event is FetchClosePlan) {
        await fetchClosePlan(event, emit);
      }
      if (event is FetchEligiblePlan) {
        await eligibleplansfortransfer(event, emit);
      }

      if (event is FetchExchangeRate) {
        await fetchExchangeRate(event, emit);
      }
      if (event is FetchPenalcharge) {
        await penalcharge(event, emit);
      }
      if (event is WithdrawPlan) {
        await withdrawPlan(event, emit);
      }
      if (event is PlanTransfer) {
        await planTransfer(event, emit);
      }
      if (event is WithholdingrateRate) {
        await withholdingrate(event, emit);
      }
      if (event is FetchInvestment) {
        await investmentrate(event, emit);
      }
      if (event is FetchPlanHistory) {
        await planhistory(event, emit);
      }
      // if (event is InitializePayment) {
      //   await initPayment(event, emit);
      // }
      if (event is PaymentInitialize) {
        await paymentInitialize(event, emit);
      }
      if (event is VerifyPayment) {
        await verifyPayment(event, emit);
      }
      // if (event is Paymentverification) {
      //   await paymentverification(event, emit);
      // }
      if (event is CompletePlanTransfer) {
        await completeTransfer(event, emit);
      }
      if (event is CreatePlan) {
        await createPlan(event, emit);
      }
      if (event is UpdatePlan) {
        await updatePlan(event, emit);
      }
      if (event is SavePlan) {
        await _savePlan(event, emit);
      }
      if (event is DeletePlan) {
        await deletePlan(event, emit);
      }
      if (event is AnyPlanAction) {
        await planAction(event, emit);
      }
      if (event is RolloverPlan) {
        await rolloverPlan(event, emit);
      }
    });
  }

  Future<void> getPlan(FetchPlan event, Emitter<CreatePlanState> emit) async {
    try {
      emit(const Fetching());

      var res = await productRepository.getPlan();

      if (res.baseStatus) {
        sessionManager.totalWorthVal = 0;
        sessionManager.activePlanVal = 0;

        for (var i = 0; i < res.plans!.length; i++) {
          var val = res.plans![i];

          if (val.planStatus == "ACTIVE") {
            planStatus.add(val.planStatus!);
          }

          if (val.planStatus == "ACTIVE" || val.planStatus == "MATURED") {
            totalWorth += res.plans![i].planSummary!.principal! *
                res.plans![i].exchangeRate!;
          }
        }
        // var data = {};
        // data["activePlan"] = planStatus.length;
        // data["totalWorth"] = totalWorth.toInt();
        sessionManager.activePlanVal = planStatus.length;
        sessionManager.totalWorthVal = totalWorth.toInt();
        emit(PlanSuccessful(planResponse: res));
      }
    } catch (e) {
      PlanError(error: e.toString());
    }
  }

  Future<void> fetchClosePlan(
      FetchClosePlan event, Emitter<CreatePlanState> emit) async {
    try {
      emit(const Fetching());

      var res = await productRepository.fetchClosePlan();

      if (res.baseStatus) {
        emit(PlanSuccessful(planResponse: res));
      }
    } catch (e) {
      PlanError(error: e.toString());
    }
  }

  Future<void> deletePlan(
      DeletePlan event, Emitter<CreatePlanState> emit) async {
    try {
      emit(const Deleting());

      var res = await productRepository.deletePlan(event.id);

      if (res.baseStatus) {
        emit(PlanSuccessful(planResponse: res));
      }
    } catch (e) {
      PlanError(error: e.toString());
    }
  }

  Future<void> eligibleplansfortransfer(
      FetchEligiblePlan event, Emitter<CreatePlanState> emit) async {
    try {
      emit(const Fetching());
      var res = await productRepository.eligibleplansfortransfer();

      if (res.baseStatus) {
        emit(PlanEligibleSuccessful(planResponse: res));
      }
    } catch (e) {
      PlanError(error: e.toString());
    }
  }

  Future<void> investmentrate(
      FetchInvestment event, Emitter<CreatePlanState> emit) async {
    try {
      // emit(const RateLoading());
      var res = await productRepository.investmentrate();
      emit(InvestmentSuccessful(investmentRateResponse: res));
    } catch (e) {}
  }

  Future<void> fetchExchangeRate(
      FetchExchangeRate event, Emitter<CreatePlanState> emit) async {
    try {
      emit(const RateLoading());
      var res = await productRepository.getExchangeRate(event.currency!);
      emit(RateSuccessful(exchangeResponse: res));
    } catch (e) {
      print(e);
    }
  }

  Future<void> penalcharge(
      FetchPenalcharge event, Emitter<CreatePlanState> emit) async {
    try {
      emit(const RateLoading());
      var res = await productRepository.penalcharge();
      emit(PenalSuccessful(penalResponse: res));
    } catch (e) {
      print(e);
    }
  }

  Future<void> withholdingrate(
      WithholdingrateRate event, Emitter<CreatePlanState> emit) async {
    try {
      // emit(const RateLoading());
      var res = await productRepository.withholdingrate();
      emit(WithholdingSuccessful(withholdingTaxResponse: res));
    } catch (e) {
      print(e);
    }
  }

  Future<void> withdrawPlan(
      WithdrawPlan event, Emitter<CreatePlanState> emit) async {
    try {
      emit(const PlanCreating());

      WithdrawPlanRequest withdrawPlanRequest = event.withdrawPlanRequest;

      var res = await productRepository.withdrawPlan(withdrawPlanRequest);

      if (res.baseStatus) {
        emit(WithdrawPlanSuccess(planResponse: res));
      } else {
        emit(WithdrawPlanError(error: res.message));
      }
    } catch (e) {
      emit(WithdrawPlanError(error: e.toString()));
    }
  }

  Future<void> planTransfer(
      PlanTransfer event, Emitter<CreatePlanState> emit) async {
    try {
      emit(const PlanCreating());

      TransferRequest transferRequest = event.transferRequest;

      var res = await productRepository.planTransfer(transferRequest);

      if (res.baseStatus) {
        emit(InitPlanTransferSuccess(initPlanTransfer: res));
      }
    } catch (e) {
      emit(PlanTransferError(error: e.toString()));
    }
  }

  Future<void> planAction(
      AnyPlanAction event, Emitter<CreatePlanState> emit) async {
    try {
      emit(const PlanCreating());

      var res = await productRepository.planActions(event.topUpRequest);

      if (res.baseStatus) {
        emit(PlanSuccessful(planResponse: res));
      }
    } catch (e) {
      emit(PlanTransferError(error: e.toString()));
    }
  }

  Future<void> rolloverPlan(
      RolloverPlan event, Emitter<CreatePlanState> emit) async {
    try {
      emit(const PlanCreating());

      var res = await productRepository.rolloverPlan(event.rolloverResquest);

      if (res.baseStatus) {
        emit(PlanSuccessful(planResponse: res));
      }
    } catch (e) {
      emit(PlanError(error: e.toString()));
    }
  }

  Future<void> completeTransfer(
      CompletePlanTransfer event, Emitter<CreatePlanState> emit) async {
    try {
      emit(const PlanCreating());

      var res = await productRepository.completePlan(event.id);

      if (res.baseStatus) {
        emit(PlanTransferSuccess(planResponse: res));
      }
    } catch (e) {
      emit(PlanTransferError(error: e.toString()));
    }
  }

  Future<void> _savePlan(SavePlan event, Emitter<CreatePlanState> emit) async {
    try {
      emit(const PlanCreating());
      var res = await productRepository.savePlan(event.topUpRequest);
      emit(PlanTransferSuccess(planResponse: res));
    } catch (e) {
      emit(PlanTransferError(error: e.toString()));
    }
  }

  Future<void> createPlan(
      CreatePlan event, Emitter<CreatePlanState> emit) async {
    try {
      emit(const PlanCreating());
      var res = await productRepository.createPlan(event.planRequest);

      emit(PlanCreatedSuccessful(createPlanResponse: res));
    } catch (e) {
      print(e);
      emit(PlanError(error: e.toString()));
    }
  }

  Future<void> updatePlan(
      UpdatePlan event, Emitter<CreatePlanState> emit) async {
    try {
      emit(const PlanCreating());
      var res = await productRepository.updatePlan(event.planRequest, event.id);

      emit(PlanUpdateSuccessful(createPlanResponse: res));
    } catch (e) {
      emit(PlanError(error: e.toString()));
    }
  }

  Future<void> planhistory(
      FetchPlanHistory event, Emitter<CreatePlanState> emit) async {
    try {
      emit(const FetchHistory());

      var res = await productRepository.planhistory(event.id);

      if (res.baseStatus) {
        emit(PlanHistorySuccess(planHistoryResponse: res));
      }
    } catch (e) {
      emit(PlanTransferError(error: e.toString()));
    }
  }

  Future<void> paymentInitialize(
      PaymentInitialize event, Emitter<CreatePlanState> emit) async {
    try {
      emit(const InitiatingPayment());
      var res = await productRepository.paymentInitialize(event.paymentInit);

      emit(PaymentSuccessful(url: res));
    } catch (e) {
      emit(PaymentError(error: e.toString()));
    }
  }

  Future<void> verifyPayment(
      VerifyPayment event, Emitter<CreatePlanState> emit) async {
    try {
      emit(const InitiatingPayment());
      var res = await productRepository.verifyPayment(event.gateWay, event.ref);

      if (res.baseStatus) {
        emit(PaymentVerified(baseResponse: res));
      }
    } catch (e) {
      emit(PaymentError(error: e.toString()));
    }
  }
  // Future<void> directDebitTestPayment(
  //     VerifyPayment event, Emitter<CreatePlanState> emit) async {
  //   try {
  //     emit(const InitiatingPayment());
  //     var res = await productRepository.directDebitTestPayment(event.ref, event.gateWay);

  //     // emit(PaymentSuccessful(url: res));
  //   } catch (e) {
  //     emit(PaymentError(error: e.toString()));
  //   }
  // }
  // Future<void> initPayment(
  //     InitializePayment event, Emitter<CreatePlanState> emit) async {
  //   try {
  //     emit(const InitiatingPayment());
  //     var res = await productRepository.initPayment(event.initPaymentRequest);

  //     emit(PaymentSuccessful(url: res));
  //   } catch (e) {
  //     emit(PaymentError(error: e.toString()));
  //   }
  // }

  // Future<void> paymentverification(
  //     Paymentverification event, Emitter<CreatePlanState> emit) async {
  //   try {
  //     emit(const PaymentLoading());
  //     var res =
  //         await productRepository.paymentverification(event.gateway, event.ref);

  //     if (res.baseStatus) {
  //       // emit(PlanSuccessful(baseResponse: res));
  //     }
  //   } catch (e) {
  //     emit(PaymentError(error: e.toString()));
  //   }
  // }
}
