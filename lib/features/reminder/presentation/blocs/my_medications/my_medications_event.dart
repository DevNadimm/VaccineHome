part of 'my_medications_bloc.dart';

abstract class MyMedicationsEvent {}

class FetchMyMedicationsEvent extends MyMedicationsEvent {}

class DeleteMedicationEvent extends MyMedicationsEvent {
  final int id;

  DeleteMedicationEvent(this.id);
}
