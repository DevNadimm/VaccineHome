part of 'patients_bloc.dart';

abstract class PatientsState {}

class PatientsInitial extends PatientsState {}

class PatientsLoading extends PatientsState {}

class PatientsLoaded extends PatientsState {
  final List<Patient> patients;

  PatientsLoaded(this.patients);
}

class PatientsFailure extends PatientsState {
  final String message;

  PatientsFailure(this.message);
}
