part of 'register_bloc.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final RegisterModel model;

  RegisterSuccess(this.model);
}

class RegisterFailure extends RegisterState {
  final String message;

  RegisterFailure(this.message);
}
