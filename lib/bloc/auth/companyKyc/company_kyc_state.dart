part of 'company_kyc_bloc.dart';

abstract class CompanyKycState extends Equatable {
  const CompanyKycState();

  @override
  List<Object> get props => [];
}

class CompanyKycInitial extends CompanyKycState {}

class CompanyKycLoading extends CompanyKycState {
  const CompanyKycLoading();
}

class CompanyKycSuccess extends CompanyKycState {
  final KycResponse kycResponse;
  const CompanyKycSuccess({required this.kycResponse});
  @override
  List<Object> get props => [kycResponse];
}

class CompanyUpdateSuccess extends CompanyKycState {
  final BaseResponse baseResponse;
  const CompanyUpdateSuccess({required this.baseResponse});
  @override
  List<Object> get props => [baseResponse];
}

class CompanyKycError extends CompanyKycState {
  final String error;
  const CompanyKycError({required this.error});
  @override
  List<Object> get props => [error];
}
