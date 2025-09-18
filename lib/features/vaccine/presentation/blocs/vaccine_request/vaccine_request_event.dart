part of 'vaccine_request_bloc.dart';

abstract class VaccineRequestEvent {}

class SendVaccineRequestEvent extends VaccineRequestEvent {
  final int divisionId;
  final int policeStationId;
  final int productId;
  final String phone;

  SendVaccineRequestEvent({
    required this.divisionId,
    required this.policeStationId,
    required this.productId,
    required this.phone,
  });
}
