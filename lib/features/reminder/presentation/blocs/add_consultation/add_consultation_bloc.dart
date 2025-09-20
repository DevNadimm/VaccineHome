import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/reminder/data/repositories/dr_consultancy_repository.dart';

part 'add_consultation_event.dart';
part 'add_consultation_state.dart';

class AddConsultationBloc extends Bloc<AddConsultationEvent, AddConsultationState> {
  AddConsultationBloc() : super(AddConsultationInitial()) {
    on<SaveAddConsultationEvent>(_onSaveAddConsultation);
  }

  Future<void> _onSaveAddConsultation(
    SaveAddConsultationEvent event,
    Emitter<AddConsultationState> emit,
  ) async {
    emit(AddConsultationLoading());
    try {
      final res = await DrConsultancyRepository.addConsultation(
        doctorName: event.doctorName,
        nextConsultationDate: event.nextConsultationDate,
        nextConsultationTime: event.nextConsultationTime,
        address: event.address,
      );
      if (res) {
        emit(AddConsultationSuccess());
      } else {
        emit(AddConsultationFailure("Unknown error occurred"));
      }
    } catch (e) {
      emit(AddConsultationFailure(e.toString()));
    }
  }
}
