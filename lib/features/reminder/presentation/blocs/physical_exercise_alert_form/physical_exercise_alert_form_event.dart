part of 'physical_exercise_alert_form_bloc.dart';

abstract class PhysicalExerciseAlertFormEvent {}

class SavePhysicalExerciseAlertEvent extends PhysicalExerciseAlertFormEvent {
  final int? id;
  final String exerciseName;
  final String duration;
  final String time;
  final String startDate;
  final String endDate;

  SavePhysicalExerciseAlertEvent({
    this.id,
    required this.exerciseName,
    required this.duration,
    required this.time,
    required this.startDate,
    required this.endDate,
  });
}