part of 'add_medication_bloc.dart';

abstract class AddMedicationState {}

class AddMedicationInitial extends AddMedicationState {}

class AddMedicationLoading extends AddMedicationState {}

class AddMedicationSuccess extends AddMedicationState {}

class AddMedicationFailure extends AddMedicationState {
  final String message;

  AddMedicationFailure(this.message);
}
