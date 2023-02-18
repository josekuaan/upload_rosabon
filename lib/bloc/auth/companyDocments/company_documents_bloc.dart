import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rosabon/model/request_model/company_document_requestion.dart';
import 'package:rosabon/model/response_models/base_response.dart';
import 'package:rosabon/model/response_models/save_document_response.dart';
import 'package:rosabon/repository/employment_repository.dart';
import 'package:rosabon/repository/general_repository.dart';

part 'company_documents_event.dart';
part 'company_documents_state.dart';

class CompanyDocumentsBloc
    extends Bloc<CompanyDocumentsEvent, CompanyDocumentsState> {
  final GeneralRepository _generalRepository = GeneralRepository();
  final EmploymentRepository _employmentRepository = EmploymentRepository();
  CompanyDocumentsBloc() : super(const CompanyDocumentsInitial()) {
    on<CompanyDocumentsEvent>((event, emit) async {
      if (event is CompanyDocuments) {
        await saveDocuments(event, emit);
      }
      if (event is CompanyOtp) {
        await otpCode(event, emit);
      }
      if (event is FetchCompanyDocument) {
        await fetchCompanyDocument(event, emit);
      }
    });
  }
  Future<void> saveDocuments(
      CompanyDocuments event, Emitter<CompanyDocumentsState> emit) async {
    try {
      emit(const CompanyDocumentsLoading());
      CompanyDocumentRequest companyDocumentRequest =
          event.companyDocumentRequest;

      var res =
          await _employmentRepository.saveCompanyDocs(companyDocumentRequest);

      if (res.baseStatus) {
        emit(CompanyDocumentsSuccess(saveDocsResponse: res));
      } else {
        emit(const CompanyDocsError(error: "error"));
      }
    } catch (e) {
      emit(CompanyDocsError(error: e.toString()));
    }
  }

  Future<void> fetchCompanyDocument(
      FetchCompanyDocument event, Emitter<CompanyDocumentsState> emit) async {
    try {
      emit(const FetchingDocument());

      var res = await _employmentRepository.fetchCompanyDocument();

      if (res.baseStatus) {
        emit(DocumentFetched(saveDocsResponse: res));
      } else {
        emit(CompanyDocsError(error: res.message));
      }
    } catch (e) {
      emit(CompanyDocsError(error: e.toString()));
    }
  }

  Future<void> otpCode(
      CompanyOtp event, Emitter<CompanyDocumentsState> emit) async {
    try {
      // emit(const FetchBankLoading());

      var res = await _generalRepository.otpCode("company");

      if (res.baseStatus) {
        emit(CompanyOtpSuccess(baseResponse: res));
      } else {
        emit(CompanyOtpError(error: res.message));
      }
    } catch (e) {
      emit(CompanyOtpError(error: e.toString()));
    }
  }
}
