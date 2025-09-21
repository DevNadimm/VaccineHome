part of 'test_form_bloc.dart';

abstract class TestFormState {}

class TestFormInitial extends TestFormState {}

class TestFormLoading extends TestFormState {}

class TestFormSuccess extends TestFormState {}

class TestFormFailure extends TestFormState {
  final String message;

  TestFormFailure(this.message);
}
