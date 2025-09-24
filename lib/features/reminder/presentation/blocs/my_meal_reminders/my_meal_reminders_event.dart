part of 'my_meal_reminders_bloc.dart';

abstract class MyMealRemindersEvent {}

class FetchMyMealRemindersEvent extends MyMealRemindersEvent {}

class DeleteMealReminderEvent extends MyMealRemindersEvent {
  final int id;

  DeleteMealReminderEvent(this.id);
}
