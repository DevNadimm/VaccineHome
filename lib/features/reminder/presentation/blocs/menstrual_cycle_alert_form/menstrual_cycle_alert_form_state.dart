part of 'menstrual_cycle_alert_form_bloc.dart';

abstract class MenstrualCycleAlertFormState {}

class MenstrualCycleAlertFormInitial extends MenstrualCycleAlertFormState {}

class MenstrualCycleAlertFormLoading extends MenstrualCycleAlertFormState {}

class MenstrualCycleAlertFormSuccess extends MenstrualCycleAlertFormState {}

class MenstrualCycleAlertFormFailure extends MenstrualCycleAlertFormState {
  final String message;

  MenstrualCycleAlertFormFailure(this.message);
}