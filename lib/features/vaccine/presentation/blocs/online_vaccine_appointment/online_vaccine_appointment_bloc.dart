import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/vaccine/data/repositories/online_vaccine_appointment_repository.dart';

part 'online_vaccine_appointment_event.dart';
part 'online_vaccine_appointment_state.dart';

class OnlineVaccineAppointmentBloc extends Bloc<OnlineVaccineAppointmentEvent, OnlineVaccineAppointmentState> {
  OnlineVaccineAppointmentBloc() : super(OnlineVaccineAppointmentInitial()) {
    on<BookVaccineAppointmentEvent>(_onBookVaccineAppointment);
  }

  Future<void> _onBookVaccineAppointment(
    BookVaccineAppointmentEvent event,
    Emitter<OnlineVaccineAppointmentState> emit,
  ) async {
    emit(OnlineVaccineAppointmentLoading());
    try {
      final res = await OnlineVaccineAppointmentRepository.bookAppointment(
        name: event.name,
        phone: event.phone,
        date: event.date,
        time: event.time,
      );
      if (res) {
        emit(OnlineVaccineAppointmentSuccess());
      } else {
        emit(OnlineVaccineAppointmentFailure("Unknown error occurred"));
      }
    } catch (e) {
      emit(OnlineVaccineAppointmentFailure(e.toString()));
    }
  }
}
