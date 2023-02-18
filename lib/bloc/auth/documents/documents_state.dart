part of 'documents_bloc.dart';

abstract class DocumentsState extends Equatable {
  const DocumentsState();

  @override
  List<Object> get props => [];
}

class DocumentsInitial extends DocumentsState {
  const DocumentsInitial();
}

class DocumentsLoading extends DocumentsState {
  const DocumentsLoading();
  @override
  List<Object> get props => [];
}

class DocumentsFetching extends DocumentsState {
  const DocumentsFetching();
  @override
  List<Object> get props => [];
}

class DocumentsSuccess extends DocumentsState {
  const DocumentsSuccess({required this.documentResponse});
  final DocumentResponse documentResponse;
  @override
  List<Object> get props => [documentResponse];
}

class DocumentLoaded extends DocumentsState {
  const DocumentLoaded({required this.documentResponse});
  final DocumentResponse documentResponse;
  @override
  List<Object> get props => [documentResponse];
}

class DocumentError extends DocumentsState {
  const DocumentError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}
