part of 'my_physical_exercise_alerts_bloc.dart';

abstract class MyPhysicalExerciseAlertsState {}

class MyPhysicalExerciseAlertsInitial extends MyPhysicalExerciseAlertsState {}

class MyPhysicalExerciseAlertsLoading extends MyPhysicalExerciseAlertsState {}

class MyPhysicalExerciseAlertsLoaded extends MyPhysicalExerciseAlertsState {
  final List<ExerciseData> myPhysicalExerciseAlerts;

  MyPhysicalExerciseAlertsLoaded(this.myPhysicalExerciseAlerts);
}

class MyPhysicalExerciseAlertsFailure extends MyPhysicalExerciseAlertsState {
  final String message;

  MyPhysicalExerciseAlertsFailure(this.message);
}

class DeletePhysicalExerciseAlertFailure extends MyPhysicalExerciseAlertsState {}
