part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginUserEvent extends LoginEvent {
  final String phone;
  final String password;

  LoginUserEvent({
    required this.phone,
    required this.password,
  });
}
