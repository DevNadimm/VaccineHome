part of 'set_new_password_bloc.dart';

abstract class SetNewPasswordState {}

class SetNewPasswordInitial extends SetNewPasswordState {}

class SetNewPasswordLoading extends SetNewPasswordState {}

class SetNewPasswordSuccess extends SetNewPasswordState {}

class SetNewPasswordFailure extends SetNewPasswordState {
  final String message;

  SetNewPasswordFailure(this.message);
}
