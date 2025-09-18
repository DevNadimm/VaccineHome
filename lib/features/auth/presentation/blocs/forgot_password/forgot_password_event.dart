part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent {}

class SendForgotPasswordPinEvent extends ForgotPasswordEvent {
  final String email;

  SendForgotPasswordPinEvent({required this.email});
}
