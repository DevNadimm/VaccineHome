import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/reminder/data/models/water_reminder_model.dart';
import 'package:vaccine_home/features/reminder/data/repositories/water_reminder_repository.dart';

part 'my_water_reminders_event.dart';
part 'my_water_reminders_state.dart';

class MyWaterRemindersBloc extends Bloc<MyWaterRemindersEvent, MyWaterRemindersState> {
  MyWaterRemindersBloc() : super(MyWaterRemindersInitial()) {
    on<FetchMyWaterRemindersEvent>(_onFetchMyWaterReminders);
    on<DeleteWaterReminderEvent>(_onDeleteWaterReminder);
  }

  Future<void> _onFetchMyWaterReminders(
    FetchMyWaterRemindersEvent event,
    Emitter<MyWaterRemindersState> emit,
  ) async {
    emit(MyWaterRemindersLoading());
    try {
      final myWaterReminders = await WaterReminderRepository.fetchMyWaterReminders();
      emit(MyWaterRemindersLoaded(myWaterReminders));
    } catch (e) {
      emit(MyWaterRemindersFailure(e.toString()));
    }
  }

  Future<void> _onDeleteWaterReminder(
    DeleteWaterReminderEvent event,
    Emitter<MyWaterRemindersState> emit,
  ) async {
    if (state is MyWaterRemindersLoaded) {
      final currentState = state as MyWaterRemindersLoaded;

      final updatedList = List<WaterData>.from(currentState.myWaterReminders)..removeWhere((water) => water.id == event.id);

      emit(MyWaterRemindersLoaded(updatedList));

      try {
        await WaterReminderRepository.deleteWaterReminder(event.id);
      } catch (e) {
        emit(DeleteWaterReminderFailure());
        emit(MyWaterRemindersLoaded(currentState.myWaterReminders));
      }
    }
  }
}
