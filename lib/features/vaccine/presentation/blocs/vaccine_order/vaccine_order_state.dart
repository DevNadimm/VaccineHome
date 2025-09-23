part of 'vaccine_order_bloc.dart';

abstract class VaccineOrderState {}

class VaccineOrderInitial extends VaccineOrderState {}

class VaccineOrderLoading extends VaccineOrderState {}

class VaccineOrderSuccess extends VaccineOrderState {}

class VaccineOrderFailure extends VaccineOrderState {
  final String message;

  VaccineOrderFailure(this.message);
}
