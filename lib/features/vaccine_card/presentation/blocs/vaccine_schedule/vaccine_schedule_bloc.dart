import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/vaccine_card/data/models/vaccine_schedule_model.dart';
import 'package:vaccine_home/features/vaccine_card/data/repositories/vaccine_schedule_repository.dart';

part 'vaccine_schedule_event.dart';
part 'vaccine_schedule_state.dart';

class VaccineScheduleBloc extends Bloc<VaccineScheduleEvent, VaccineScheduleState> {
  VaccineScheduleBloc() : super(VaccineScheduleInitial()) {
    on<FetchVaccineSchedulesEvent>(_onFetchVaccineSchedules);
  }

  Future<void> _onFetchVaccineSchedules(
    FetchVaccineSchedulesEvent event,
    Emitter<VaccineScheduleState> emit,
  ) async {
    emit(VaccineScheduleLoading());
    try {
      final schedules = await VaccineScheduleRepository.fetchVaccineSchedules();
      emit(VaccineScheduleLoaded(schedules));
    } catch (e) {
      emit(VaccineScheduleFailure(e.toString()));
    }
  }
}
