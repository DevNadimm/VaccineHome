part of 'add_test_bloc.dart';

abstract class AddTestEvent {}

class SaveAddTestEvent extends AddTestEvent {
  final String testName;
  final String nextTestDate;
  final String nextTestTime;
  final String description;

  SaveAddTestEvent({
    required this.testName,
    required this.nextTestDate,
    required this.nextTestTime,
    required this.description,
  });
}
