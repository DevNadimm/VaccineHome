part of 'my_tests_bloc.dart';

abstract class MyTestsState {}

class MyTestsInitial extends MyTestsState {}

class MyTestsLoading extends MyTestsState {}

class MyTestsLoaded extends MyTestsState {
  final List<Pathology> myTests;

  MyTestsLoaded(this.myTests);
}

class MyTestsFailure extends MyTestsState {
  final String message;

  MyTestsFailure(this.message);
}
