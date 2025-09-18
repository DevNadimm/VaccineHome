part of 'add_consultation_bloc.dart';

abstract class AddConsultationState {}

class AddConsultationInitial extends AddConsultationState {}

class AddConsultationLoading extends AddConsultationState {}

class AddConsultationSuccess extends AddConsultationState {}

class AddConsultationFailure extends AddConsultationState {
  final String message;

  AddConsultationFailure(this.message);
}
