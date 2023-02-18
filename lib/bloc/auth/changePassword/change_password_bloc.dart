import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rosabon/model/request_model/forgot_password_request.dart';
import 'package:rosabon/model/request_model/reset_password.dart';
import 'package:rosabon/repository/auth_repository.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final AuthRepository _authRepository = AuthRepository();
  ChangePasswordBloc() : super(const ChangePasswordInitial()) {
    on<ChangePasswordEvent>((event, emit) async {
      if (event is ChangePassword) {
        await changePassword(event, emit);
      }
      if (event is ResetPassword) {
        await resetPassword(event, emit);
      }
    });
  }

  Future<void> changePassword(
      ChangePassword event, Emitter<ChangePasswordState> emit) async {
    try {
      emit(const ChangePasswordLoading());

      ChangePasswordRequest changePasswordRequest = event.changePasswordRequest;

      var response =
          await _authRepository.changePassword(changePasswordRequest);

      if (response.baseStatus) {
        emit(const ChangePasswordSuccess());
      } else {}
    } catch (e) {}
  }

  Future<void> resetPassword(
      ResetPassword event, Emitter<ChangePasswordState> emit) async {
    try {
      emit(const ChangePasswordLoading());

      ResetPasswordRequest resetPasswordRequest = event.resetPasswordRequest;

      var response =
          await _authRepository.resetPassword(resetPasswordRequest);

      if (response.baseStatus) {
        emit(const ChangePasswordSuccess());
      } else {}
    } catch (e) {}
  }
}
