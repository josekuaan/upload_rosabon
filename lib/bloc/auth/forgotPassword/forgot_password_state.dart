part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {
  const ForgotPasswordInitial();
}

class ForgotPasswordLoading extends ForgotPasswordState {
  const ForgotPasswordLoading();
  @override
  List<Object> get props => [];
}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final ForgotPasswordResponse forgotPasswordResponse;
  const ForgotPasswordSuccess({required this.forgotPasswordResponse});

  @override
  List<Object> get props => [forgotPasswordResponse];
}

class ForgotPasswordError extends ForgotPasswordState {
  final String error;
  const ForgotPasswordError({required this.error});
  @override
  List<Object> get props => [error];
}
