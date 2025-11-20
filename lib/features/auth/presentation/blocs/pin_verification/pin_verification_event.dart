part of 'pin_verification_bloc.dart';

abstract class PinVerificationEvent {}

class VerifyPinEvent extends PinVerificationEvent {
  final String phone;
  final String pin;

  VerifyPinEvent({required this.phone, required this.pin});
}
