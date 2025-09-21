import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/reminder/data/repositories/dr_consultancy_repository.dart';

part 'consultation_form_event.dart';
part 'consultation_form_state.dart';

class ConsultationFormBloc extends Bloc<ConsultationFormEvent, ConsultationFormState> {
  ConsultationFormBloc() : super(ConsultationFormInitial()) {
    on<SaveConsultationEvent>(_onSaveConsultation);
  }

  Future<void> _onSaveConsultation(
    SaveConsultationEvent event,
    Emitter<ConsultationFormState> emit,
  ) async {
    emit(ConsultationFormLoading());
    try {
      bool res;
      if (event.id == null) {
        res = await DrConsultancyRepository.addConsultation(
          doctorName: event.doctorName,
          nextConsultationDate: event.nextConsultationDate,
          nextConsultationTime: event.nextConsultationTime,
          address: event.address,
        );
      } else {
        res = await DrConsultancyRepository.updateConsultation(
          id: event.id!,
          doctorName: event.doctorName,
          nextConsultationDate: event.nextConsultationDate,
          nextConsultationTime: event.nextConsultationTime,
          address: event.address,
        );
      }

      if (res) {
        emit(ConsultationFormSuccess());
      } else {
        emit(ConsultationFormFailure("Unknown error occurred"));
      }
    } catch (e) {
      emit(ConsultationFormFailure(e.toString()));
    }
  }
}
