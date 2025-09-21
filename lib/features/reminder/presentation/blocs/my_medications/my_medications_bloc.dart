import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/reminder/data/models/medication_model.dart';
import 'package:vaccine_home/features/reminder/data/repositories/medication_repository.dart';

part 'my_medications_event.dart';
part 'my_medications_state.dart';

class MyMedicationsBloc extends Bloc<MyMedicationsEvent, MyMedicationsState> {
  MyMedicationsBloc() : super(MyMedicationsInitial()) {
    on<FetchMyMedicationsEvent>(_onFetchMyMedications);
    on<DeleteMedicationEvent>(_onDeleteMedication);
  }

  Future<void> _onFetchMyMedications(
    FetchMyMedicationsEvent event,
    Emitter<MyMedicationsState> emit,
  ) async {
    emit(MyMedicationsLoading());
    try {
      final myMedications = await MedicationRepository.fetchMyMedications();
      emit(MyMedicationsLoaded(myMedications));
    } catch (e) {
      emit(MyMedicationsFailure(e.toString()));
    }
  }

  Future<void> _onDeleteMedication(
    DeleteMedicationEvent event,
    Emitter<MyMedicationsState> emit,
  ) async {
    if (state is MyMedicationsLoaded) {
      final currentState = state as MyMedicationsLoaded;

      final updatedList = List<Medication>.from(currentState.myMedications)..removeWhere((med) => med.id == event.id);

      emit(MyMedicationsLoaded(updatedList));

      try {
        await MedicationRepository.deleteMedication(event.id);
      } catch (e) {
        emit(MyMedicationsLoaded(currentState.myMedications));
      }
    }
  }
}
