part of 'my_medications_bloc.dart';

abstract class MyMedicationsState {}

class MyMedicationsInitial extends MyMedicationsState {}

class MyMedicationsLoading extends MyMedicationsState {}

class MyMedicationsLoaded extends MyMedicationsState {
  final List<Medication> myMedications;

  MyMedicationsLoaded(this.myMedications);
}

class MyMedicationsFailure extends MyMedicationsState {
  final String message;

  MyMedicationsFailure(this.message);
}
