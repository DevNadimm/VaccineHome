part of 'menstrual_cycle_alert_form_bloc.dart';

abstract class MenstrualCycleAlertFormEvent {}

class SaveMenstrualCycleAlertEvent extends MenstrualCycleAlertFormEvent {
  final int? id;
  final String lastCycleStartDate;
  final String lastCycleEndDate;

  SaveMenstrualCycleAlertEvent({
    this.id,
    required this.lastCycleStartDate,
    required this.lastCycleEndDate,
  });
}