part of 'add_medication_bloc.dart';

abstract class AddMedicationEvent {}

class SaveAddMedicationEvent extends AddMedicationEvent {
  final String name;
  final String type;
  final List<String> times;
  final String whenToTake;

  SaveAddMedicationEvent({
    required this.name,
    required this.type,
    required this.times,
    required this.whenToTake,
  });
}
