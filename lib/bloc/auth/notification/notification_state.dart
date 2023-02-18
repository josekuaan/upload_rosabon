part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {
  const NotificationLoading();
}

class NotificationSuccess extends NotificationState {
  final NotificationResponse notificationResponse;
  const NotificationSuccess({required this.notificationResponse});
  @override
  List<Object> get props => [notificationResponse];
}
