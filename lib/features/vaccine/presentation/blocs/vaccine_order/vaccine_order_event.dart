part of 'vaccine_order_bloc.dart';

abstract class VaccineOrderEvent {}

class SendVaccineOrderEvent extends VaccineOrderEvent {
  final String phone;
  final String address;
  final int productId;

  SendVaccineOrderEvent({
    required this.phone,
    required this.address,
    required this.productId,
  });
}
