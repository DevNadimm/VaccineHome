part of 'vaccine_request_bloc.dart';

abstract class VaccineRequestState {}

class VaccineRequestInitial extends VaccineRequestState {}

class VaccineRequestLoading extends VaccineRequestState {}

class VaccineRequestSuccess extends VaccineRequestState {}

class VaccineRequestFailure extends VaccineRequestState {
  final String message;

  VaccineRequestFailure(this.message);
}
