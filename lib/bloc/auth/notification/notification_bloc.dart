import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rosabon/model/response_models/notification_response.dart';
import 'package:rosabon/repository/auth_repository.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final AuthRepository _authRepository = AuthRepository();
  NotificationBloc() : super(NotificationInitial()) {
    on<NotificationEvent>((event, emit) async {
      if (event is FetchNotification) {
        await notification(event, emit);
      }
    });
  }

  Future<void> notification(
      FetchNotification event, Emitter<NotificationState> emit) async {
    try {
      emit(const NotificationLoading());

      var response = await _authRepository.notification();

      if (response.baseStatus) {
        emit(NotificationSuccess(notificationResponse: response));
      } else {}
    } catch (e) {}
  }
}
