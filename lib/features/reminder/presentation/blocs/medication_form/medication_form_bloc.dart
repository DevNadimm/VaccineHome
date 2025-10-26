import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/reminder/data/repositories/medication_repository.dart';

part 'medication_form_event.dart';
part 'medication_form_state.dart';

class MedicationFormBloc extends Bloc<MedicationFormEvent, MedicationFormState> {
  MedicationFormBloc() : super(MedicationFormInitial()) {
    on<SaveMedicationEvent>(_onSaveMedication);
  }

  Future<void> _onSaveMedication(
    SaveMedicationEvent event,
    Emitter<MedicationFormState> emit,
  ) async {
    emit(MedicationFormLoading());

    try {
      bool res;

      if (event.id == null) {
        res = await MedicationRepository.addMedication(
          name: event.name,
          type: event.type,
          times: event.times,
          whenToTake: event.whenToTake,
          duration: event.duration,
          startDate: event.startDate,
          endDate: event.endDate,
        );
      } else {
        res = await MedicationRepository.updateMedication(
          id: event.id!,
          name: event.name,
          type: event.type,
          times: event.times,
          whenToTake: event.whenToTake,
          duration: event.duration,
          startDate: event.startDate,
          endDate: event.endDate,
        );
      }

      if (res) {
        emit(MedicationFormSuccess());
      } else {
        emit(MedicationFormFailure("Failed to save medication."));
      }
    } catch (e) {
      emit(MedicationFormFailure(e.toString()));
    }
  }
}
