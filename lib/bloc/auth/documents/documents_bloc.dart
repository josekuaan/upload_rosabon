import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rosabon/model/request_model/document_request.dart';
import 'package:rosabon/model/response_models/document_response.dart';
import 'package:rosabon/repository/employment_repository.dart';

part 'documents_event.dart';
part 'documents_state.dart';

class DocsBloc extends Bloc<DocumentsEvent, DocumentsState> {
  final EmploymentRepository _employmentRepository = EmploymentRepository();

  DocsBloc() : super(const DocumentsInitial()) {
    on<DocumentsEvent>((event, emit) async {
      if (event is SaveDocument) {
        await saveDocuments(event, emit);
      }
      if (event is FetchDocument) {
        await fetchDocument(event, emit);
      }
    });
  }

  Future<void> saveDocuments(
      SaveDocument event, Emitter<DocumentsState> emit) async {
    try {
      emit(const DocumentsLoading());
      DocumentRequest documentRequest = event.documentRequest;
      var res = await _employmentRepository.saveDocs(documentRequest);

      if (res.baseStatus) {
        emit(DocumentsSuccess(documentResponse: res));
      }
    } catch (e) {
      emit(DocumentError(error: e.toString()));
    }
  }

  Future<void> fetchDocument(
      FetchDocument event, Emitter<DocumentsState> emit) async {
    try {
      emit(const DocumentsFetching());

      var res = await _employmentRepository.fetchDocument();

      if (res.baseStatus) {
        emit(DocumentLoaded(documentResponse: res));
      } else {
        emit(DocumentError(error: res.message));
      }
    } catch (e) {
      emit(DocumentError(error: e.toString()));
    }
  }
}
