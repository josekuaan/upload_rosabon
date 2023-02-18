part of 'wallet_bloc.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object> get props => [];
}

class FetchWalletBalance extends WalletEvent {
  const FetchWalletBalance();
  @override
  List<Object> get props => [];
}

class FetchWalletTransctions extends WalletEvent {
  const FetchWalletTransctions();
  @override
  List<Object> get props => [];
}

class FetchDepositTransctions extends WalletEvent {
  const FetchDepositTransctions();
  @override
  List<Object> get props => [];
}

class FetchWithdrawalReason extends WalletEvent {
  const FetchWithdrawalReason();
  @override
  List<Object> get props => [];
}

class WithdrawNow extends WalletEvent {
  final WithdrawalRequest withdrawalRequest;
  const WithdrawNow({required this.withdrawalRequest});
  @override
  List<Object> get props => [withdrawalRequest];
}

class WalletTransfer extends WalletEvent {
  final WalletPlanTransferRequest walletPlanTransferRequest;
  const WalletTransfer({required this.walletPlanTransferRequest});
  @override
  List<Object> get props => [walletPlanTransferRequest];
}

class PokeUser extends WalletEvent {
  final int id;

  const PokeUser({required this.id});
  @override
  List<Object> get props => [];
}

class RedeemSpecialBonus extends WalletEvent {
  const RedeemSpecialBonus();
  @override
  List<Object> get props => [];
}

class Redeembonus extends WalletEvent {
  const Redeembonus();
  @override
  List<Object> get props => [];
}

class MyRefers extends WalletEvent {
  const MyRefers();
  @override
  List<Object> get props => [];
}

class MyRefersActivitty extends WalletEvent {
  const MyRefersActivitty();
  @override
  List<Object> get props => [];
}

class FetchThreshold extends WalletEvent {
  const FetchThreshold();
  @override
  List<Object> get props => [];
}

class SpecialActivity extends WalletEvent {
  const SpecialActivity();
  @override
  List<Object> get props => [];
}

class GetTotalSpecialEarning extends WalletEvent {
  const GetTotalSpecialEarning();
  @override
  List<Object> get props => [];
}

class Totalearning extends WalletEvent {
  const Totalearning();
  @override
  List<Object> get props => [];
}
