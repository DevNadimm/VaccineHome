part of 'water_reminder_form_bloc.dart';

abstract class WaterReminderFormEvent {}

class SaveWaterReminderEvent extends WaterReminderFormEvent {
  final int? id;
  final int totalWater;
  final List<String> waterTimes;

  SaveWaterReminderEvent({
    this.id,
    required this.totalWater,
    required this.waterTimes,
  });
}
