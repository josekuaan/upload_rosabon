import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rosabon/model/request_model/forgot_password_request.dart';
import 'package:rosabon/model/response_models/forgot_password_response.dart';
import 'package:rosabon/repository/auth_repository.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthRepository _authRepository = AuthRepository();
  ForgotPasswordBloc() : super(const ForgotPasswordInitial()) {
    on<ForgotPasswordEvent>((event, emit) async {
      if (event is ForgotPassword) {
        await forgotPassword(event, emit);
      }
    });
  }

  Future<void> forgotPassword(
      ForgotPassword event, Emitter<ForgotPasswordState> emit) async {
    try {
      emit(const ForgotPasswordLoading());

      ForgotPasswordRequest forgotPasswordRequest = event.forgotPasswordRequest;

      var response =
          await _authRepository.forgotPassword(forgotPasswordRequest);

      if (response.baseStatus) {
        emit(ForgotPasswordSuccess(forgotPasswordResponse: response));
      } else {
        emit(ForgotPasswordError(error: response.message));
      }
    } catch (e) {
      emit(ForgotPasswordError(error: e.toString()));
    }
  }
}
