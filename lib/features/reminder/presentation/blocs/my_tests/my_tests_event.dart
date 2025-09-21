part of 'my_tests_bloc.dart';

abstract class MyTestsEvent {}

class FetchMyTestsEvent extends MyTestsEvent {}

class DeleteTestEvent extends MyTestsEvent {
  final int id;

  DeleteTestEvent(this.id);
}
