part of 'medication_form_bloc.dart';

abstract class MedicationFormEvent {}

class SaveMedicationEvent extends MedicationFormEvent {
  final int? id;
  final String name;
  final String type;
  final List<String> times;
  final String whenToTake;
  final String duration;
  final String? startDate;
  final String? endDate;

  SaveMedicationEvent({
    this.id,
    required this.name,
    required this.type,
    required this.times,
    required this.whenToTake,
    required this.duration,
    this.startDate,
    this.endDate,
  });
}
