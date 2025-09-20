part of 'vaccine_card_request_bloc.dart';

abstract class VaccineCardRequestState {}

class VaccineCardRequestInitial extends VaccineCardRequestState {}

class VaccineCardRequestLoading extends VaccineCardRequestState {}

class VaccineCardRequestSuccess extends VaccineCardRequestState {}

class VaccineCardRequestFailure extends VaccineCardRequestState {
  final String message;

  VaccineCardRequestFailure(this.message);
}
