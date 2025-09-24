part of 'my_meal_reminders_bloc.dart';

abstract class MyMealRemindersState {}

class MyMealRemindersInitial extends MyMealRemindersState {}

class MyMealRemindersLoading extends MyMealRemindersState {}

class MyMealRemindersLoaded extends MyMealRemindersState {
  final List<MealData> myMealReminders;

  MyMealRemindersLoaded(this.myMealReminders);
}

class MyMealRemindersFailure extends MyMealRemindersState {
  final String message;

  MyMealRemindersFailure(this.message);
}

class DeleteMealReminderFailure extends MyMealRemindersState {}
