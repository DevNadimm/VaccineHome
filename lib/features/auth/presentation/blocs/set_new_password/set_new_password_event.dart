part of 'set_new_password_bloc.dart';

abstract class SetNewPasswordEvent {}

class SetPasswordEvent extends SetNewPasswordEvent {
  final String phone;
  final String pin;
  final String newPassword;
  final String confirmNewPassword;

  SetPasswordEvent({
    required this.phone,
    required this.pin,
    required this.newPassword,
    required this.confirmNewPassword,
  });
}
