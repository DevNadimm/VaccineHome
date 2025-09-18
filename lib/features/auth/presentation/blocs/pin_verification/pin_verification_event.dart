part of 'pin_verification_bloc.dart';

abstract class PinVerificationEvent {}

class VerifyPinEvent extends PinVerificationEvent {
  final String email;
  final String pin;

  VerifyPinEvent({required this.email, required this.pin});
}
