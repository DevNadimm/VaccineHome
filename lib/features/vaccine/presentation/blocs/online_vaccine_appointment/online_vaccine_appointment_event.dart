part of 'online_vaccine_appointment_bloc.dart';

abstract class OnlineVaccineAppointmentEvent {}

class BookVaccineAppointmentEvent extends OnlineVaccineAppointmentEvent {
  final String name;
  final String phone;
  final String date;
  final String time;

  BookVaccineAppointmentEvent({
    required this.name,
    required this.phone,
    required this.date,
    required this.time,
  });
}
