part of 'add_consultation_bloc.dart';

abstract class AddConsultationEvent {}

class SaveAddConsultationEvent extends AddConsultationEvent {
  final String doctorName;
  final String nextConsultationDate;
  final String nextConsultationTime;
  final String address;

  SaveAddConsultationEvent({
    required this.doctorName,
    required this.nextConsultationDate,
    required this.nextConsultationTime,
    required this.address,
  });
}
