import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/vaccine_card/data/models/patients_model.dart';
import 'package:vaccine_home/features/vaccine_card/data/repositories/patients_repository.dart';

part 'patients_event.dart';
part 'patients_state.dart';

class PatientsBloc extends Bloc<PatientsEvent, PatientsState> {
  PatientsBloc() : super(PatientsInitial()) {
    on<FetchPatientsEvent>(_onFetchPatients);
  }

  Future<void> _onFetchPatients(
    FetchPatientsEvent event,
    Emitter<PatientsState> emit,
  ) async {
    emit(PatientsLoading());
    try {
      final patients = await PatientsRepository.fetchPatients();
      emit(PatientsLoaded(patients));
    } catch (e) {
      emit(PatientsFailure(e.toString()));
    }
  }
}
