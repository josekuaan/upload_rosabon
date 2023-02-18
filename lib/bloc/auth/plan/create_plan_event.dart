part of 'create_plan_bloc.dart';

abstract class CreatePlanEvent extends Equatable {
  const CreatePlanEvent();

  @override
  List<Object> get props => [];
}



class FetchPlan extends CreatePlanEvent {
  const FetchPlan();
}

class FetchClosePlan extends CreatePlanEvent {
  const FetchClosePlan();
}

class FetchEligiblePlan extends CreatePlanEvent {
  const FetchEligiblePlan();
}

class InitializePayment extends CreatePlanEvent {
  final InitPaymentRequest initPaymentRequest;
  const InitializePayment({required this.initPaymentRequest});
  @override
  List<Object> get props => [initPaymentRequest];
}

class PaymentInitialize extends CreatePlanEvent {
  final PaymentInit paymentInit;
  const PaymentInitialize({required this.paymentInit});
  @override
  List<Object> get props => [paymentInit];
}

class VerifyPayment extends CreatePlanEvent {
  final String ref;
  final String gateWay;
  const VerifyPayment({required this.ref, required this.gateWay});
  @override
  List<Object> get props => [ref, gateWay];
}
class DirectDebitTest extends CreatePlanEvent {
  final String ref;
  final String gateWay;
  const DirectDebitTest({required this.ref, required this.gateWay});
  @override
  List<Object> get props => [ref, gateWay];
}

class FetchCurrency extends CreatePlanEvent {
  const FetchCurrency();
}

class FetchExchangeRate extends CreatePlanEvent {
  final String? currency;
  const FetchExchangeRate({required this.currency});
}

class FetchTenor extends CreatePlanEvent {
  const FetchTenor();
}

class FetchInvestment extends CreatePlanEvent {
  const FetchInvestment();
}

class WithholdingrateRate extends CreatePlanEvent {
  const WithholdingrateRate();
}

class CreatePlan extends CreatePlanEvent {
  final PlanRequest planRequest;
  const CreatePlan({required this.planRequest});
  @override
  List<Object> get props => [planRequest];
}

class UpdatePlan extends CreatePlanEvent {
  final PlanRequest planRequest;
  final int id;
  const UpdatePlan({required this.planRequest, required this.id});
  @override
  List<Object> get props => [planRequest, id];
}

class WithdrawPlan extends CreatePlanEvent {
  final WithdrawPlanRequest withdrawPlanRequest;
  const WithdrawPlan({required this.withdrawPlanRequest});
  @override
  List<Object> get props => [withdrawPlanRequest];
}

class SavePlan extends CreatePlanEvent {
  final TopUpRequest topUpRequest;
  const SavePlan({required this.topUpRequest});
  @override
  List<Object> get props => [topUpRequest];
}

class PlanTransfer extends CreatePlanEvent {
  final TransferRequest transferRequest;
  const PlanTransfer({required this.transferRequest});
  @override
  List<Object> get props => [transferRequest];
}

class CompletePlanTransfer extends CreatePlanEvent {
  final int id;
  const CompletePlanTransfer({required this.id});
  @override
  List<Object> get props => [id];
}

class FetchPlanHistory extends CreatePlanEvent {
  final int id;
  const FetchPlanHistory({required this.id});
  @override
  List<Object> get props => [id];
}

class Paymentverification extends CreatePlanEvent {
  final String gateway, ref;
  const Paymentverification(this.gateway, this.ref);
  @override
  List<Object> get props => [gateway, ref];
}

class DeletePlan extends CreatePlanEvent {
  final int id;
  const DeletePlan({required this.id});
  @override
  List<Object> get props => [id];
}

class AnyPlanAction extends CreatePlanEvent {
  final TopUpRequest topUpRequest;
  const AnyPlanAction({required this.topUpRequest});
  @override
  List<Object> get props => [topUpRequest];
}

class RolloverPlan extends CreatePlanEvent {
  final RolloverResquest rolloverResquest;
  const RolloverPlan({required this.rolloverResquest});
  @override
  List<Object> get props => [rolloverResquest];
}

class FetchPenalcharge extends CreatePlanEvent {
  const FetchPenalcharge();
  @override
  List<Object> get props => [];
}
