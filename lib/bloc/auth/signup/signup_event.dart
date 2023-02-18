part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();
}

class SignuUp extends SignupEvent {
  final SignUpRequest signUpRequest;

  const SignuUp({required this.signUpRequest});

  @override
  List<Object?> get props => [signUpRequest];
}

class RequesterTokn extends SignupEvent {
  const RequesterTokn({required this.registerTokenRequest});
  final RegisterTokenRequest registerTokenRequest;
  @override
  List<Object> get props => [registerTokenRequest];
}

class FetchSource extends SignupEvent {
  const FetchSource();
  @override
  List<Object?> get props => [];
}
