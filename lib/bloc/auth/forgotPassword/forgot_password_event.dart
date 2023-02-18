part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPassword extends ForgotPasswordEvent {
  final ForgotPasswordRequest forgotPasswordRequest;

  const ForgotPassword({required this.forgotPasswordRequest});

  List<Object?> get prop => [forgotPasswordRequest];
}
