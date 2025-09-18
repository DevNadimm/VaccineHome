part of 'pin_verification_bloc.dart';

abstract class PinVerificationState {}

class PinVerificationInitial extends PinVerificationState {}

class PinVerificationLoading extends PinVerificationState {}

class PinVerificationSuccess extends PinVerificationState {}

class PinVerificationFailure extends PinVerificationState {
  final String message;

  PinVerificationFailure(this.message);
}
