part of 'water_reminder_form_bloc.dart';

abstract class WaterReminderFormState {}

class WaterReminderFormInitial extends WaterReminderFormState {}

class WaterReminderFormLoading extends WaterReminderFormState {}

class WaterReminderFormSuccess extends WaterReminderFormState {}

class WaterReminderFormFailure extends WaterReminderFormState {
  final String message;

  WaterReminderFormFailure(this.message);
}
