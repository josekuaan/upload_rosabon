part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangePassword extends ChangePasswordEvent {
  final ChangePasswordRequest changePasswordRequest;
  const ChangePassword({required this.changePasswordRequest});
  List<Object?> get prop => [];
}

class ResetPassword extends ChangePasswordEvent {
  final ResetPasswordRequest resetPasswordRequest;
  const ResetPassword({required this.resetPasswordRequest});
  List<Object?> get prop => [];
}
