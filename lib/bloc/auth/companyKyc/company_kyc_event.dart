part of 'company_kyc_bloc.dart';

abstract class CompanyKycEvent extends Equatable {
  const CompanyKycEvent();

  @override
  List<Object> get props => [];
}

class CompanyKyc extends CompanyKycEvent {
  final KycRequest kycRequest;
  const CompanyKyc({required this.kycRequest});

  List<Object> get prop => [kycRequest];
}

class CompanyUpdate extends CompanyKycEvent {
  final CompanyDetailsUpdateequest companyDetailsUpdateequest;
  const CompanyUpdate({required this.companyDetailsUpdateequest});

  List<Object> get prop => [companyDetailsUpdateequest];
}
