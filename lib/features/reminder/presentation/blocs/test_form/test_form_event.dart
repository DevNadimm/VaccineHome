part of 'test_form_bloc.dart';

abstract class TestFormEvent {}

class SaveTestFormEvent extends TestFormEvent {
  final int? id;
  final String testName;
  final String nextTestDate;
  final String nextTestTime;
  final String description;

  SaveTestFormEvent({
    this.id,
    required this.testName,
    required this.nextTestDate,
    required this.nextTestTime,
    required this.description,
  });
}
