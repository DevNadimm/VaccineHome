import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/reminder/data/repositories/medication_repository.dart';

part 'add_medication_event.dart';
part 'add_medication_state.dart';

class AddMedicationBloc extends Bloc<AddMedicationEvent, AddMedicationState> {
  AddMedicationBloc() : super(AddMedicationInitial()) {
    on<SaveAddMedicationEvent>(_onSaveAddMedication);
  }

  Future<void> _onSaveAddMedication(
    SaveAddMedicationEvent event,
    Emitter<AddMedicationState> emit,
  ) async {
    emit(AddMedicationLoading());
    try {
      final res = await MedicationRepository.addMedication(
        name: event.name,
        type: event.type,
        times: event.times,
        whenToTake: event.whenToTake,
      );
      if (res) emit(AddMedicationSuccess());
    } catch (e) {
      emit(AddMedicationFailure(e.toString()));
    }
  }
}
