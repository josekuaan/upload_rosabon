part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class Login extends LoginEvent {
  final Loginrequest loginrequest;
  const Login({required this.loginrequest});

  List<Object?> get prop => [loginrequest];
}
