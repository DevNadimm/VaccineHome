part of 'my_sleep_reminders_bloc.dart';

abstract class MySleepRemindersState {}

class MySleepRemindersInitial extends MySleepRemindersState {}

class MySleepRemindersLoading extends MySleepRemindersState {}

class MySleepRemindersLoaded extends MySleepRemindersState {
  final List<SleepData> mySleepReminders;

  MySleepRemindersLoaded(this.mySleepReminders);
}

class MySleepRemindersFailure extends MySleepRemindersState {
  final String message;

  MySleepRemindersFailure(this.message);
}

class DeleteSleepReminderFailure extends MySleepRemindersState {}
