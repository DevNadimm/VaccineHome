part of 'my_water_reminders_bloc.dart';

abstract class MyWaterRemindersState {}

class MyWaterRemindersInitial extends MyWaterRemindersState {}

class MyWaterRemindersLoading extends MyWaterRemindersState {}

class MyWaterRemindersLoaded extends MyWaterRemindersState {
  final List<WaterData> myWaterReminders;

  MyWaterRemindersLoaded(this.myWaterReminders);
}

class MyWaterRemindersFailure extends MyWaterRemindersState {
  final String message;

  MyWaterRemindersFailure(this.message);
}

class DeleteWaterReminderFailure extends MyWaterRemindersState {}
