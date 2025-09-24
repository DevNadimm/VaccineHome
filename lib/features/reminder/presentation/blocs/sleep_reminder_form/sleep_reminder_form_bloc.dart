import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/reminder/data/repositories/sleep_reminder_repository.dart';

part 'sleep_reminder_form_event.dart';
part 'sleep_reminder_form_state.dart';

class SleepReminderFormBloc extends Bloc<SleepReminderFormEvent, SleepReminderFormState> {
  SleepReminderFormBloc() : super(SleepReminderFormInitial()) {
    on<SaveSleepReminderEvent>(_onSaveSleepReminder);
  }

  Future<void> _onSaveSleepReminder(
    SaveSleepReminderEvent event,
    Emitter<SleepReminderFormState> emit,
  ) async {
    emit(SleepReminderFormLoading());

    try {
      bool res;
      if (event.id == null) {
        res = await SleepReminderRepository.addSleepReminder(
          sleepTime: event.sleepTime,
        );
      } else {
        res = await SleepReminderRepository.updateSleepReminder(
          id: event.id!,
          sleepTime: event.sleepTime,
        );
      }

      if (res) emit(SleepReminderFormSuccess());
    } catch (e) {
      emit(SleepReminderFormFailure(e.toString()));
    }
  }
}
