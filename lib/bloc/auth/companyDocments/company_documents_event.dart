part of 'company_documents_bloc.dart';

abstract class CompanyDocumentsEvent extends Equatable {
  const CompanyDocumentsEvent();

  @override
  List<Object> get props => [];
}

class CompanyDocuments extends CompanyDocumentsEvent {
  const CompanyDocuments({required this.companyDocumentRequest});
  final CompanyDocumentRequest companyDocumentRequest;

  @override
  List<Object> get props => [companyDocumentRequest];
}

class CompanyOtp extends CompanyDocumentsEvent {
  const CompanyOtp();

  @override
  List<Object> get props => [];
}

class FetchCompanyDocument extends CompanyDocumentsEvent {
  const FetchCompanyDocument();
  @override
  List<Object> get props => [];
}
