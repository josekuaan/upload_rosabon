part of 'director_bloc.dart';

abstract class DirectorEvent extends Equatable {
  const DirectorEvent();

  @override
  List<Object> get props => [];
}

class SaveDirector extends DirectorEvent {
  final List<Map<String, dynamic>> directorRequest;

  const SaveDirector({required this.directorRequest});
  @override
  List<Object> get props => [directorRequest];
}

class FetchDirector extends DirectorEvent {
  const FetchDirector();
  @override
  List<Object> get props => [];
}

class SendOtpDirector extends DirectorEvent {
  const SendOtpDirector();
  @override
  List<Object> get props => [];
}

class DeleteDirector extends DirectorEvent {
  final int id;
  const DeleteDirector({required this.id});
  @override
  List<Object> get props => [id];
}
