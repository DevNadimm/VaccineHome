part of 'online_vaccine_appointment_bloc.dart';

abstract class OnlineVaccineAppointmentState {}

class OnlineVaccineAppointmentInitial extends OnlineVaccineAppointmentState {}

class OnlineVaccineAppointmentLoading extends OnlineVaccineAppointmentState {}

class OnlineVaccineAppointmentSuccess extends OnlineVaccineAppointmentState {}

class OnlineVaccineAppointmentFailure extends OnlineVaccineAppointmentState {
  final String message;

  OnlineVaccineAppointmentFailure(this.message);
}
