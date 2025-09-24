part of 'my_water_reminders_bloc.dart';

abstract class MyWaterRemindersEvent {}

class FetchMyWaterRemindersEvent extends MyWaterRemindersEvent {}

class DeleteWaterReminderEvent extends MyWaterRemindersEvent {
  final int id;

  DeleteWaterReminderEvent(this.id);
}