part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class Loginloading extends LoginState {
  const Loginloading();

  List<Object?> get prop => [];
}

class LoginSuccess extends LoginState {
  final LoginResponse loginResponse;
  const LoginSuccess({required this.loginResponse});

  List<Object?> get prop => [loginResponse];
}

class LoginError extends LoginState {
  final String error;
  const LoginError({required this.error});

  List<Object?> get prop => [error];
}
