part of 'bank_bloc.dart';

abstract class BankEvent extends Equatable {
  const BankEvent();

  @override
  List<Object> get props => [];
}

class FetchBanks extends BankEvent {
  const FetchBanks();

  @override
  List<Object> get props => [];
}

class FetchBankAccount extends BankEvent {
  const FetchBankAccount();

  @override
  List<Object> get props => [];
}

class ViewBankDetail extends BankEvent {
  final int id;
  const ViewBankDetail({required this.id});
  @override
  List<Object> get props => [id];
}

class VirtualAccount extends BankEvent {
  final String action;
  final String planName;
  const VirtualAccount({required this.action, required this.planName});
  @override
  List<Object> get props => [action, planName];
}

class Otp extends BankEvent {
  const Otp();

  @override
  List<Object> get props => [];
}

class ValidateOtp extends BankEvent {
  final String otp;
  const ValidateOtp({required this.otp});

  @override
  List<Object> get props => [otp];
}

class VerifyAccount extends BankEvent {
  const VerifyAccount({required this.verifyAccountRequest});
  final VerifyAccountRequest verifyAccountRequest;
  @override
  List<Object> get props => [verifyAccountRequest];
}

class UpdateBankAccount extends BankEvent {
  const UpdateBankAccount({required this.bankRequest});
  final BankRequest bankRequest;
  @override
  List<Object> get props => [bankRequest];
}

class ValidatePhone extends BankEvent {
  const ValidatePhone({this.personalInformationRequest});
  final PersonalInformationRequest? personalInformationRequest;
  // final String? otp;
  @override
  List<Object> get props => [personalInformationRequest!];
}
