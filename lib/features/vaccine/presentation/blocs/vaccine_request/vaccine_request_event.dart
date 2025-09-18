part of 'vaccine_request_bloc.dart';

abstract class VaccineRequestEvent {}

class SendVaccineRequestEvent extends VaccineRequestEvent {
  final String phone;
  final String address;
  final int productId;

  SendVaccineRequestEvent({
    required this.phone,
    required this.address,
    required this.productId,
  });
}
