part of 'register_bloc.dart';

abstract class RegisterEvent {}

class RegisterUserEvent extends RegisterEvent {
  final String name;
  final String phone;
  final String dateOfBirth;
  final String password;
  final String confirmPassword;

  RegisterUserEvent({
    required this.name,
    required this.phone,
    required this.dateOfBirth,
    required this.password,
    required this.confirmPassword,
  });
}
