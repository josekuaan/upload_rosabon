part of 'wallet_bloc.dart';

abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object> get props => [];
}

class WalletInitial extends WalletState {
  const WalletInitial();
}

class WalletTransLoading extends WalletState {
  const WalletTransLoading();
  @override
  List<Object> get props => [];
}

class WalletBalanceLoading extends WalletState {
  const WalletBalanceLoading();
  @override
  List<Object> get props => [];
}

class WithdrawalLoading extends WalletState {
  const WithdrawalLoading();
  @override
  List<Object> get props => [];
}

class MyRefersLoading extends WalletState {
  const MyRefersLoading();
  @override
  List<Object> get props => [];
}

class PokeLoading extends WalletState {
  const PokeLoading();
}

class Walletsuccess extends WalletState {
  final WalletResponse walletResponse;
  const Walletsuccess({required this.walletResponse});

  @override
  List<Object> get props => [walletResponse];
}

class MyRefersSuccess extends WalletState {
  final MyreferalResponse myreferalResponse;
  const MyRefersSuccess({required this.myreferalResponse});

  @override
  List<Object> get props => [myreferalResponse];
}

class ReferalBonusSuccess extends WalletState {
  final BonuResponse bonuResponse;
  const ReferalBonusSuccess({required this.bonuResponse});

  @override
  List<Object> get props => [bonuResponse];
}

class TransactionSuccess extends WalletState {
  final TransactionResponse transactionResponse;
  const TransactionSuccess({required this.transactionResponse});

  @override
  List<Object> get props => [transactionResponse];
}

class BankDepositSuccess extends WalletState {
  final DepositHistoryResponse depositHistoryResponse;
  const BankDepositSuccess({required this.depositHistoryResponse});

  @override
  List<Object> get props => [depositHistoryResponse];
}

class WithdrawalReasonSuccess extends WalletState {
  final WithdrawalReasonResponse withdrawalReasonResponse;
  const WithdrawalReasonSuccess({required this.withdrawalReasonResponse});

  @override
  List<Object> get props => [withdrawalReasonResponse];
}

class WithdrawalSuccess extends WalletState {
  final BaseResponse baseResponse;
  const WithdrawalSuccess({required this.baseResponse});

  @override
  List<Object> get props => [baseResponse];
}

class TotalearningSuccess extends WalletState {
  final BaseResponse baseResponse;
  const TotalearningSuccess({required this.baseResponse});

  @override
  List<Object> get props => [baseResponse];
}

class TotalSpecialEarningSuccess extends WalletState {
  final BaseResponse baseResponse;
  const TotalSpecialEarningSuccess({required this.baseResponse});

  @override
  List<Object> get props => [baseResponse];
}

class PokeSuccess extends WalletState {
  final BaseResponse baseResponse;
  const PokeSuccess({required this.baseResponse});

  @override
  List<Object> get props => [baseResponse];
}

class WalletTransferSuccess extends WalletState {
  final BaseResponse baseResponse;
  const WalletTransferSuccess({required this.baseResponse});

  @override
  List<Object> get props => [baseResponse];
}

class WithdrawalError extends WalletState {
  final String error;
  const WithdrawalError({required this.error});

  @override
  List<Object> get props => [error];
}

class WalletTransferError extends WalletState {
  final String error;
  const WalletTransferError({required this.error});

  @override
  List<Object> get props => [error];
}

class MyRefersError extends WalletState {
  final String error;
  const MyRefersError({required this.error});

  @override
  List<Object> get props => [error];
}

class PokeError extends WalletState {
  final String error;
  const PokeError({required this.error});

  @override
  List<Object> get props => [error];
}

class TransactError extends WalletState {
  final String error;
  const TransactError({required this.error});

  @override
  List<Object> get props => [error];
}
