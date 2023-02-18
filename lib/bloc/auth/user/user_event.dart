part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class FetchUser extends UserEvent {
  const FetchUser({required this.name});
  final String name;
  @override
  List<Object> get props => [];
}

class GeneralOtp extends UserEvent {
  const GeneralOtp({this.message});
  final String? message;
  @override
  List<Object> get props => [message!];
}

class IndividualOtp extends UserEvent {
  const IndividualOtp();

  @override
  List<Object> get props => [];
}

class IdentificationType extends UserEvent {
  const IdentificationType();

  @override
  List<Object> get props => [];
}
