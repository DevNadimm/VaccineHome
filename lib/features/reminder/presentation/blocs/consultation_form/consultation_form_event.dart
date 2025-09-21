part of 'consultation_form_bloc.dart';

abstract class ConsultationFormEvent {}

class SaveConsultationEvent extends ConsultationFormEvent {
  final int? id;
  final String doctorName;
  final String nextConsultationDate;
  final String nextConsultationTime;
  final String address;

  SaveConsultationEvent({
    this.id,
    required this.doctorName,
    required this.nextConsultationDate,
    required this.nextConsultationTime,
    required this.address,
  });
}
