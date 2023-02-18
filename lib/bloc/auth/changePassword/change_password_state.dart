part of 'change_password_bloc.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {
  const ChangePasswordInitial();
  @override
  List<Object> get props => [];
}

class ChangePasswordLoading extends ChangePasswordState {
  const ChangePasswordLoading();
  @override
  List<Object> get props => [];
}

class ChangePasswordSuccess extends ChangePasswordState {
  const ChangePasswordSuccess();
  @override
  List<Object> get props => [];
}
