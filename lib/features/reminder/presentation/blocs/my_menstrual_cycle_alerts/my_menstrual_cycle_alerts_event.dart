part of 'my_menstrual_cycle_alerts_bloc.dart';

abstract class MyMenstrualCycleAlertsEvent {}

class FetchMyMenstrualCycleAlertsEvent extends MyMenstrualCycleAlertsEvent {}

class DeleteMenstrualCycleAlertEvent extends MyMenstrualCycleAlertsEvent {
  final int id;

  DeleteMenstrualCycleAlertEvent(this.id);
}
