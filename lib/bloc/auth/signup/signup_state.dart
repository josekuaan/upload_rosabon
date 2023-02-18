part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {
  const SignupInitial();
}

class SignupLoading extends SignupState {
  const SignupLoading();

  @override
  List<Object> get props => [];
}

class SignupSuccess extends SignupState {
  const SignupSuccess({required this.signUpReponse});
  final SignUpReponse signUpReponse;

  @override
  List<Object> get props => [signUpReponse];
}

class SourceSuccess extends SignupState {
  const SourceSuccess({required this.sourceResponse});
  final SourceResponse sourceResponse;

  @override
  List<Object> get props => [sourceResponse];
}

class SignupError extends SignupState {
  const SignupError({required this.error});
  final String error;

  @override
  List<Object> get props => [error];
}
