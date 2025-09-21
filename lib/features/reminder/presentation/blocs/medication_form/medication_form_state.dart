part of 'medication_form_bloc.dart';

abstract class MedicationFormState {}

class MedicationFormInitial extends MedicationFormState {}

class MedicationFormLoading extends MedicationFormState {}

class MedicationFormSuccess extends MedicationFormState {}

class MedicationFormFailure extends MedicationFormState {
  final String message;

  MedicationFormFailure(this.message);
}
