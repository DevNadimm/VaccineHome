part of 'vaccine_schedule_bloc.dart';

abstract class VaccineScheduleState {}

class VaccineScheduleInitial extends VaccineScheduleState {}

class VaccineScheduleLoading extends VaccineScheduleState {}

class VaccineScheduleLoaded extends VaccineScheduleState {
  final List<VaccineScheduleData> schedules;

  VaccineScheduleLoaded(this.schedules);
}

class VaccineScheduleFailure extends VaccineScheduleState {
  final String message;

  VaccineScheduleFailure(this.message);
}
