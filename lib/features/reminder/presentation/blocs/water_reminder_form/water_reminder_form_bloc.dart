import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/reminder/data/repositories/water_reminder_repository.dart';

part 'water_reminder_form_event.dart';
part 'water_reminder_form_state.dart';

class WaterReminderFormBloc extends Bloc<WaterReminderFormEvent, WaterReminderFormState> {
  WaterReminderFormBloc() : super(WaterReminderFormInitial()) {
    on<SaveWaterReminderEvent>(_onSaveWaterReminder);
  }

  Future<void> _onSaveWaterReminder(
    SaveWaterReminderEvent event,
    Emitter<WaterReminderFormState> emit,
  ) async {
    emit(WaterReminderFormLoading());

    try {
      bool res;
      if (event.id == null) {
        res = await WaterReminderRepository.addWaterReminder(
          totalWater: event.totalWater,
          waterTimes: event.waterTimes,
        );
      } else {
        res = await WaterReminderRepository.updateWaterReminder(
          id: event.id!,
          totalWater: event.totalWater,
          waterTimes: event.waterTimes,
        );
      }

      if (res) emit(WaterReminderFormSuccess());
    } catch (e) {
      emit(WaterReminderFormFailure(e.toString()));
    }
  }
}
