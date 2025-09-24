part of 'my_sleep_reminders_bloc.dart';

abstract class MySleepRemindersEvent {}

class FetchMySleepRemindersEvent extends MySleepRemindersEvent {}

class DeleteSleepReminderEvent extends MySleepRemindersEvent {
  final int id;

  DeleteSleepReminderEvent(this.id);
}
