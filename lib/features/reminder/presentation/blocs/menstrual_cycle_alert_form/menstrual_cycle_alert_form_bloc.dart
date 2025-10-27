import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/reminder/data/repositories/menstrual_cycle_alert_repository.dart';

part 'menstrual_cycle_alert_form_event.dart';
part 'menstrual_cycle_alert_form_state.dart';

class MenstrualCycleAlertFormBloc extends Bloc<MenstrualCycleAlertFormEvent, MenstrualCycleAlertFormState> {
  MenstrualCycleAlertFormBloc() : super(MenstrualCycleAlertFormInitial()) {
    on<SaveMenstrualCycleAlertEvent>(_onSaveMenstrualCycleAlert);
  }

  Future<void> _onSaveMenstrualCycleAlert(
    SaveMenstrualCycleAlertEvent event,
    Emitter<MenstrualCycleAlertFormState> emit,
  ) async {
    emit(MenstrualCycleAlertFormLoading());

    try {
      bool res;
      if (event.id == null) {
        res = await MenstrualCycleAlertRepository.addMenstrualCycleAlert(
          lastCycleStartDate: event.lastCycleStartDate,
          lastCycleEndDate: event.lastCycleEndDate,
        );
      } else {
        res = await MenstrualCycleAlertRepository.updateMenstrualCycleAlert(
          id: event.id!,
          lastCycleStartDate: event.lastCycleStartDate,
          lastCycleEndDate: event.lastCycleEndDate,
        );
      }

      if (res) emit(MenstrualCycleAlertFormSuccess());
    } catch (e) {
      emit(MenstrualCycleAlertFormFailure(e.toString()));
    }
  }
}
