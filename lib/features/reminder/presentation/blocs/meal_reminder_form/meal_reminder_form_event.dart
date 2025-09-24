part of 'meal_reminder_form_bloc.dart';

abstract class MealReminderFormEvent {}

class SaveMealReminderEvent extends MealReminderFormEvent {
  final int? id;
  final String mealDescription;
  final List<String> mealTimes;

  SaveMealReminderEvent({
    this.id,
    required this.mealDescription,
    required this.mealTimes,
  });
}
