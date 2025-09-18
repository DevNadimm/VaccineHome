part of 'vaccine_product_bloc.dart';

abstract class VaccineProductState {}

class VaccineProductInitial extends VaccineProductState {}

class VaccineProductLoading extends VaccineProductState {}

class VaccineProductSuccess extends VaccineProductState {
  final List<VaccineProduct> products;

  VaccineProductSuccess(this.products);
}

class VaccineProductFailure extends VaccineProductState {
  final String message;

  VaccineProductFailure(this.message);
}
