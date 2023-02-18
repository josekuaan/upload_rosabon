part of 'create_plan_bloc.dart';

abstract class CreatePlanState extends Equatable {
  const CreatePlanState();

  @override
  List<Object> get props => [];
}

class CreatePlanInitial extends CreatePlanState {}

class Fetching extends CreatePlanState {
  const Fetching();
}

class RateLoading extends CreatePlanState {
  const RateLoading();
}

class TenorLoading extends CreatePlanState {
  const TenorLoading();

  List<Object?> get prop => [];
}

class PlanCreating extends CreatePlanState {
  const PlanCreating();

  List<Object?> get prop => [];
}

class FetchHistory extends CreatePlanState {
  const FetchHistory();

  List<Object?> get prop => [];
}

class PaymentLoading extends CreatePlanState {
  const PaymentLoading();

  List<Object?> get prop => [];
}

class InitiatingPayment extends CreatePlanState {
  const InitiatingPayment();
}

class Deleting extends CreatePlanState {
  const Deleting();

  List<Object?> get prop => [];
}

class WithholdingSuccessful extends CreatePlanState {
  final WithholdingTaxResponse withholdingTaxResponse;
  const WithholdingSuccessful({required this.withholdingTaxResponse});
  @override
  List<Object> get props => [withholdingTaxResponse];
}

class RateSuccessful extends CreatePlanState {
  final ExchangeResponse exchangeResponse;
  const RateSuccessful({required this.exchangeResponse});
  @override
  List<Object> get props => [exchangeResponse];
}

class PenalSuccessful extends CreatePlanState {
  final PenalResponse penalResponse;
  const PenalSuccessful({required this.penalResponse});
  @override
  List<Object> get props => [penalResponse];
}

class InvestmentSuccessful extends CreatePlanState {
  final InvestmentRateResponse investmentRateResponse;
  const InvestmentSuccessful({required this.investmentRateResponse});
  @override
  List<Object> get props => [investmentRateResponse];
}


class PlanSuccessful extends CreatePlanState {
  final PlanResponse planResponse;
  const PlanSuccessful({required this.planResponse});
  @override
  List<Object> get props => [planResponse];
}

class PlanCreatedSuccessful extends CreatePlanState {
  final CreatePlanResponse createPlanResponse;
  const PlanCreatedSuccessful({required this.createPlanResponse});
  @override
  List<Object> get props => [createPlanResponse];
}

class PlanUpdateSuccessful extends CreatePlanState {
  final CreatePlanResponse createPlanResponse;
  const PlanUpdateSuccessful({required this.createPlanResponse});
  @override
  List<Object> get props => [createPlanResponse];
}

class PlanEligibleSuccessful extends CreatePlanState {
  final PlanResponse planResponse;
  const PlanEligibleSuccessful({required this.planResponse});
  @override
  List<Object> get props => [planResponse];
}

class CreatePlanSuccessful extends CreatePlanState {
  final PlanResponse planResponse;
  const CreatePlanSuccessful({required this.planResponse});
  @override
  List<Object> get props => [planResponse];
}

class PaymentSuccessful extends CreatePlanState {
  final String url;
  const PaymentSuccessful({required this.url});
  @override
  List<Object> get props => [url];
}

class PaymentVerified extends CreatePlanState {
  final BaseResponse baseResponse;
  const PaymentVerified({required this.baseResponse});
  @override
  List<Object> get props => [baseResponse];
}

class PlanTransferSuccess extends CreatePlanState {
  final PlanResponse planResponse;
  const PlanTransferSuccess({required this.planResponse});
  @override
  List<Object> get props => [planResponse];
}

class PlanHistorySuccess extends CreatePlanState {
  final PlanHistoryResponse planHistoryResponse;
  const PlanHistorySuccess({required this.planHistoryResponse});
  @override
  List<Object> get props => [planHistoryResponse];
}

class InitPlanTransferSuccess extends CreatePlanState {
  final InitPlanTransfer initPlanTransfer;
  const InitPlanTransferSuccess({required this.initPlanTransfer});
  @override
  List<Object> get props => [initPlanTransfer];
}

class WithdrawPlanSuccess extends CreatePlanState {
  final PlanResponse planResponse;
  const WithdrawPlanSuccess({required this.planResponse});

  @override
  List<Object> get props => [planResponse];
}



class PaymentError extends CreatePlanState {
  final String error;
  const PaymentError({required this.error});
  @override
  List<Object> get props => [error];
}

class PlanError extends CreatePlanState {
  final String error;
  const PlanError({required this.error});
  @override
  List<Object> get props => [error];
}

class PlanTransferError extends CreatePlanState {
  final String error;
  const PlanTransferError({required this.error});
  @override
  List<Object> get props => [error];
}

class WithdrawPlanError extends CreatePlanState {
  final String error;
  const WithdrawPlanError({required this.error});
  @override
  List<Object> get props => [error];
}
