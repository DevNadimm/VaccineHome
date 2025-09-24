import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/reminder/data/models/sleep_reminder_model.dart';
import 'package:vaccine_home/features/reminder/data/repositories/sleep_reminder_repository.dart';

part 'my_sleep_reminders_event.dart';
part 'my_sleep_reminders_state.dart';

class MySleepRemindersBloc extends Bloc<MySleepRemindersEvent, MySleepRemindersState> {
  MySleepRemindersBloc() : super(MySleepRemindersInitial()) {
    on<FetchMySleepRemindersEvent>(_onFetchMySleepReminders);
    on<DeleteSleepReminderEvent>(_onDeleteSleepReminder);
  }

  Future<void> _onFetchMySleepReminders(
    FetchMySleepRemindersEvent event,
    Emitter<MySleepRemindersState> emit,
  ) async {
    emit(MySleepRemindersLoading());
    try {
      final mySleepReminders = await SleepReminderRepository.fetchMySleepReminders();
      emit(MySleepRemindersLoaded(mySleepReminders));
    } catch (e) {
      emit(MySleepRemindersFailure(e.toString()));
    }
  }

  Future<void> _onDeleteSleepReminder(
    DeleteSleepReminderEvent event,
    Emitter<MySleepRemindersState> emit,
  ) async {
    if (state is MySleepRemindersLoaded) {
      final currentState = state as MySleepRemindersLoaded;

      final updatedList = List<SleepData>.from(currentState.mySleepReminders)..removeWhere((sleep) => sleep.id == event.id);

      emit(MySleepRemindersLoaded(updatedList));

      try {
        await SleepReminderRepository.deleteSleepReminder(event.id);
      } catch (e) {
        emit(DeleteSleepReminderFailure());
        emit(MySleepRemindersLoaded(currentState.mySleepReminders));
      }
    }
  }
}
