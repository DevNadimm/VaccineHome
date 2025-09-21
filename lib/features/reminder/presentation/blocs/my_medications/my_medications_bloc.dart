import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/reminder/data/models/medication_model.dart';
import 'package:vaccine_home/features/reminder/data/repositories/medication_repository.dart';

part 'my_medications_event.dart';
part 'my_medications_state.dart';

class MyMedicationsBloc extends Bloc<MyMedicationsEvent, MyMedicationsState> {
  MyMedicationsBloc() : super(MyMedicationsInitial()) {
    on<MyMedicationsEvent>(_onFetchMyMedications);
  }

  Future<void> _onFetchMyMedications(
    MyMedicationsEvent event,
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
}
