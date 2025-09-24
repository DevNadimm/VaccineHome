part of 'meal_reminder_form_bloc.dart';

abstract class MealReminderFormState {}

class MealReminderFormInitial extends MealReminderFormState {}

class MealReminderFormLoading extends MealReminderFormState {}

class MealReminderFormSuccess extends MealReminderFormState {}

class MealReminderFormFailure extends MealReminderFormState {
  final String message;

  MealReminderFormFailure(this.message);
}