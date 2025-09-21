part of 'my_consultations_bloc.dart';

abstract class MyConsultationsEvent {}

class FetchMyConsultationsEvent extends MyConsultationsEvent {}

class DeleteConsultationEvent extends MyConsultationsEvent {
  final int id;

  DeleteConsultationEvent(this.id);
}
