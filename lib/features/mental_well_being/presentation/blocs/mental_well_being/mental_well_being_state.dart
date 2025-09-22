part of 'mental_well_being_bloc.dart';

abstract class MentalWellBeingState {}

class MentalWellBeingInitial extends MentalWellBeingState {}

class MentalWellBeingLoading extends MentalWellBeingState {}

class MentalWellBeingLoaded extends MentalWellBeingState {
  final List<MentalWellBeingItem> items;

  MentalWellBeingLoaded(this.items);
}

class MentalWellBeingFailure extends MentalWellBeingState {
  final String message;

  MentalWellBeingFailure(this.message);
}
