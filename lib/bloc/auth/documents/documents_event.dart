part of 'documents_bloc.dart';

abstract class DocumentsEvent extends Equatable {
  const DocumentsEvent();

  @override
  List<Object> get props => [];
}

class SaveDocument extends DocumentsEvent {
  const SaveDocument({required this.documentRequest});
  final DocumentRequest documentRequest;

  @override
  List<Object> get props => [documentRequest];
}

class FetchDocument extends DocumentsEvent {
  const FetchDocument();

  @override
  List<Object> get props => [];
}
