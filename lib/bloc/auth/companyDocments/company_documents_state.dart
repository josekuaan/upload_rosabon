part of 'company_documents_bloc.dart';

abstract class CompanyDocumentsState extends Equatable {
  const CompanyDocumentsState();

  @override
  List<Object> get props => [];
}

class CompanyDocumentsInitial extends CompanyDocumentsState {
  const CompanyDocumentsInitial();
}

class CompanyDocumentsLoading extends CompanyDocumentsState {
  const CompanyDocumentsLoading();
  @override
  List<Object> get props => [];
}

class CompanyOtpLoading extends CompanyDocumentsState {
  const CompanyOtpLoading();
}

class FetchingDocument extends CompanyDocumentsState {
  const FetchingDocument();
}

class CompanyDocumentsSuccess extends CompanyDocumentsState {
  const CompanyDocumentsSuccess({required this.saveDocsResponse});
  final SaveDocsResponse saveDocsResponse;
  @override
  List<Object> get props => [saveDocsResponse];
}

class DocumentFetched extends CompanyDocumentsState {
  const DocumentFetched({required this.saveDocsResponse});
  final SaveDocsResponse saveDocsResponse;
  @override
  List<Object> get props => [saveDocsResponse];
}

class CompanyOtpSuccess extends CompanyDocumentsState {
  const CompanyOtpSuccess({required this.baseResponse});
  final BaseResponse baseResponse;
  @override
  List<Object> get props => [baseResponse];
}

class CompanyOtpError extends CompanyDocumentsState {
  const CompanyOtpError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class CompanyDocsError extends CompanyDocumentsState {
  const CompanyDocsError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}
