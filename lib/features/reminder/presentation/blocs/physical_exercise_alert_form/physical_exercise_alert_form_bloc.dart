import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/reminder/data/repositories/physical_exercise_alert_repository.dart';

part 'physical_exercise_alert_form_event.dart';
part 'physical_exercise_alert_form_state.dart';

class PhysicalExerciseAlertFormBloc extends Bloc<PhysicalExerciseAlertFormEvent, PhysicalExerciseAlertFormState> {
  PhysicalExerciseAlertFormBloc() : super(PhysicalExerciseAlertFormInitial()) {
    on<SavePhysicalExerciseAlertEvent>(_onSavePhysicalExerciseAlert);
  }

  Future<void> _onSavePhysicalExerciseAlert(
    SavePhysicalExerciseAlertEvent event,
    Emitter<PhysicalExerciseAlertFormState> emit,
  ) async {
    emit(PhysicalExerciseAlertFormLoading());

    try {
      bool res;
      if (event.id == null) {
        res = await PhysicalExerciseAlertRepository.addPhysicalExerciseAlert(
          exerciseName: event.exerciseName,
          duration: event.duration,
          time: event.time,
          startDate: event.startDate,
          endDate: event.endDate,
        );
      } else {
        res = await PhysicalExerciseAlertRepository.updatePhysicalExerciseAlert(
          id: event.id!,
          exerciseName: event.exerciseName,
          duration: event.duration,
          time: event.time,
          startDate: event.startDate,
          endDate: event.endDate,
        );
      }

      if (res) emit(PhysicalExerciseAlertFormSuccess());
    } catch (e) {
      emit(PhysicalExerciseAlertFormFailure(e.toString()));
    }
  }
}
