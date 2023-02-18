part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {
  const UserInitial();
}

class UserLoading extends UserState {
  const UserLoading();
  @override
  List<Object> get props => [];
}

class FetchUserSuccess extends UserState {
  final UserResponse userResponse;
  const FetchUserSuccess({required this.userResponse});

  @override
  List<Object> get props => [userResponse];
}

class IdentificationSuccess extends UserState {
  final IdentityReponse identityReponse;
  const IdentificationSuccess({required this.identityReponse});

  @override
  List<Object> get props => [identityReponse];
}

class UserError extends UserState {
  final String error;
  const UserError({required this.error});

  List<Object?> get prop => [error];
}

class OtpSuccess extends UserState {
  const OtpSuccess({required this.baseResponse});
  final BaseResponse baseResponse;
  @override
  List<Object> get props => [baseResponse];
}

class OtpError extends UserState {
  const OtpError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}
