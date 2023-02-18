part of 'bank_bloc.dart';

abstract class BankState extends Equatable {
  const BankState();

  @override
  List<Object> get props => [];
}

class BankInitial extends BankState {
  const BankInitial();
}

class FetchBankLoading extends BankState {
  const FetchBankLoading();
  @override
  List<Object> get props => [];
}

class OtpLoading extends BankState {
  const OtpLoading();
}

class VerifyAccountLoading extends BankState {
  const VerifyAccountLoading();
  @override
  List<Object> get props => [];
}

class BankLoading extends BankState {
  const BankLoading();
  @override
  List<Object> get props => [];
}

class FetchBankSuccess extends BankState {
  const FetchBankSuccess({required this.banksResponse});
  final BanksResponse banksResponse;
  @override
  List<Object> get props => [banksResponse];
}

class FetchAccountSuccess extends BankState {
  const FetchAccountSuccess({required this.bankAccountResponse});
  final BankAccountResponse bankAccountResponse;
  @override
  List<Object> get props => [bankAccountResponse];
}

class VirtualAccountSuccess extends BankState {
  const VirtualAccountSuccess({required this.virtualAccountResponse});
  final VirtualAccountResponse virtualAccountResponse;
  @override
  List<Object> get props => [virtualAccountResponse];
}

class OtpSuccess extends BankState {
  const OtpSuccess({required this.baseResponse});
  final BaseResponse baseResponse;
  @override
  List<Object> get props => [baseResponse];
}

class PhoneVerified extends BankState {
  const PhoneVerified({required this.baseResponse});
  final BaseResponse baseResponse;
  @override
  List<Object> get props => [baseResponse];
}

class VerifyAccountSuccess extends BankState {
  const VerifyAccountSuccess({required this.verifyAccountResponse});
  final VerifyAccountResponse verifyAccountResponse;
  @override
  List<Object> get props => [verifyAccountResponse];
}

class BankSavedSuccess extends BankState {
  const BankSavedSuccess({required this.updateAccountResponse});
  final UpdateAccountResponse updateAccountResponse;
  @override
  List<Object> get props => [updateAccountResponse];
}

class OtpError extends BankState {
  const OtpError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class BankSavedError extends BankState {
  const BankSavedError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class VerifyAccountError extends BankState {
  const VerifyAccountError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}
