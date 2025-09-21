part of 'consultation_form_bloc.dart';

abstract class ConsultationFormState {}

class ConsultationFormInitial extends ConsultationFormState {}

class ConsultationFormLoading extends ConsultationFormState {}

class ConsultationFormSuccess extends ConsultationFormState {}

class ConsultationFormFailure extends ConsultationFormState {
  final String message;

  ConsultationFormFailure(this.message);
}
