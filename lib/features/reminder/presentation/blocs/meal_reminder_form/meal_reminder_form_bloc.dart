import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/reminder/data/repositories/meal_reminder_repository.dart';

part 'meal_reminder_form_event.dart';
part 'meal_reminder_form_state.dart';

class MealReminderFormBloc extends Bloc<MealReminderFormEvent, MealReminderFormState> {
  MealReminderFormBloc() : super(MealReminderFormInitial()) {
    on<SaveMealReminderEvent>(_onSaveMealReminder);
  }

  Future<void> _onSaveMealReminder(
    SaveMealReminderEvent event,
    Emitter<MealReminderFormState> emit,
  ) async {
    emit(MealReminderFormLoading());

    try {
      bool res;
      if (event.id == null) {
        res = await MealReminderRepository.addMealReminder(
          mealDescription: event.mealDescription,
          mealTimes: event.mealTimes,
        );
      } else {
        res = await MealReminderRepository.updateMealReminder(
          id: event.id!,
          mealDescription: event.mealDescription,
          mealTimes: event.mealTimes,
        );
      }

      if (res) emit(MealReminderFormSuccess());
    } catch (e) {
      emit(MealReminderFormFailure(e.toString()));
    }
  }
}
