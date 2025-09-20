part of 'my_consultations_bloc.dart';

abstract class MyConsultationsState {}

class MyConsultationsInitial extends MyConsultationsState {}

class MyConsultationsLoading extends MyConsultationsState {}

class MyConsultationsLoaded extends MyConsultationsState {
  final List<DrConsultancy> myConsultations;

  MyConsultationsLoaded(this.myConsultations);
}

class MyConsultationsFailure extends MyConsultationsState {
  final String message;

  MyConsultationsFailure(this.message);
}
