part of 'sleep_reminder_form_bloc.dart';

abstract class SleepReminderFormState {}

class SleepReminderFormInitial extends SleepReminderFormState {}

class SleepReminderFormLoading extends SleepReminderFormState {}

class SleepReminderFormSuccess extends SleepReminderFormState {}

class SleepReminderFormFailure extends SleepReminderFormState {
  final String message;

  SleepReminderFormFailure(this.message);
}
