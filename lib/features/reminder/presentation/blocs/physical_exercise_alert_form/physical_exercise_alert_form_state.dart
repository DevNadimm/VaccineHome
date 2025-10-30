part of 'physical_exercise_alert_form_bloc.dart';

abstract class PhysicalExerciseAlertFormState {}

class PhysicalExerciseAlertFormInitial extends PhysicalExerciseAlertFormState {}

class PhysicalExerciseAlertFormLoading extends PhysicalExerciseAlertFormState {}

class PhysicalExerciseAlertFormSuccess extends PhysicalExerciseAlertFormState {}

class PhysicalExerciseAlertFormFailure extends PhysicalExerciseAlertFormState {
  final String message;

  PhysicalExerciseAlertFormFailure(this.message);
}