part of 'my_menstrual_cycle_alerts_bloc.dart';

abstract class MyMenstrualCycleAlertsState {}

class MyMenstrualCycleAlertsInitial extends MyMenstrualCycleAlertsState {}

class MyMenstrualCycleAlertsLoading extends MyMenstrualCycleAlertsState {}

class MyMenstrualCycleAlertsLoaded extends MyMenstrualCycleAlertsState {
  final List<MenstrualCycleData> myMenstrualCycleAlerts;

  MyMenstrualCycleAlertsLoaded(this.myMenstrualCycleAlerts);
}

class MyMenstrualCycleAlertsFailure extends MyMenstrualCycleAlertsState {
  final String message;

  MyMenstrualCycleAlertsFailure(this.message);
}

class DeleteMenstrualCycleAlertFailure extends MyMenstrualCycleAlertsState {}
