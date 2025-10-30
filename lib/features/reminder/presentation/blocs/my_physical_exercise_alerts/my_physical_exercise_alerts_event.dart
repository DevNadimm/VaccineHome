part of 'my_physical_exercise_alerts_bloc.dart';

abstract class MyPhysicalExerciseAlertsEvent {}

class FetchMyPhysicalExerciseAlertsEvent extends MyPhysicalExerciseAlertsEvent {}

class DeletePhysicalExerciseAlertEvent extends MyPhysicalExerciseAlertsEvent {
  final int id;

  DeletePhysicalExerciseAlertEvent(this.id);
}
