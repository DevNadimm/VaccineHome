import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/reminder/data/models/meal_reminder_model.dart';
import 'package:vaccine_home/features/reminder/data/repositories/meal_reminder_repository.dart';

part 'my_meal_reminders_event.dart';
part 'my_meal_reminders_state.dart';

class MyMealRemindersBloc extends Bloc<MyMealRemindersEvent, MyMealRemindersState> {
  MyMealRemindersBloc() : super(MyMealRemindersInitial()) {
    on<FetchMyMealRemindersEvent>(_onFetchMyMealReminders);
    on<DeleteMealReminderEvent>(_onDeleteMealReminder);
  }

  Future<void> _onFetchMyMealReminders(
    FetchMyMealRemindersEvent event,
    Emitter<MyMealRemindersState> emit,
  ) async {
    emit(MyMealRemindersLoading());
    try {
      final myMealReminders = await MealReminderRepository.fetchMyMealReminders();
      emit(MyMealRemindersLoaded(myMealReminders));
    } catch (e) {
      emit(MyMealRemindersFailure(e.toString()));
    }
  }

  Future<void> _onDeleteMealReminder(
    DeleteMealReminderEvent event,
    Emitter<MyMealRemindersState> emit,
  ) async {
    if (state is MyMealRemindersLoaded) {
      final currentState = state as MyMealRemindersLoaded;

      final updatedList = List<MealData>.from(currentState.myMealReminders)..removeWhere((meal) => meal.id == event.id);

      emit(MyMealRemindersLoaded(updatedList));

      try {
        await MealReminderRepository.deleteMealReminder(event.id);
      } catch (e) {
        emit(DeleteMealReminderFailure());
        emit(MyMealRemindersLoaded(currentState.myMealReminders));
      }
    }
  }
}
