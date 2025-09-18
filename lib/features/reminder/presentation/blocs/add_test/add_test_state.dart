part of 'add_test_bloc.dart';

abstract class AddTestState {}

class AddTestInitial extends AddTestState {}

class AddTestLoading extends AddTestState {}

class AddTestSuccess extends AddTestState {}

class AddTestFailure extends AddTestState {
  final String message;

  AddTestFailure(this.message);
}
