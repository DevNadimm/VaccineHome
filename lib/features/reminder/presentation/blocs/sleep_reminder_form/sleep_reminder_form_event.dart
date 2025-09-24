part of 'sleep_reminder_form_bloc.dart';

abstract class SleepReminderFormEvent {}

class SaveSleepReminderEvent extends SleepReminderFormEvent {
  final int? id;
  final String sleepTime;

  SaveSleepReminderEvent({
    this.id,
    required this.sleepTime,
  });
}
