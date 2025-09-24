part of 'vaccine_order_history_bloc.dart';

class VaccineOrderHistoryState {}

class VaccineOrderHistoryInitial extends VaccineOrderHistoryState {}

class VaccineOrderHistoryLoading extends VaccineOrderHistoryState {}

class VaccineOrderHistoryLoaded extends VaccineOrderHistoryState {
  final List<VaccineOrderData> vaccineOrderHistory;

  VaccineOrderHistoryLoaded(this.vaccineOrderHistory);
}

class VaccineOrderHistoryFailure extends VaccineOrderHistoryState {
  final String message;

  VaccineOrderHistoryFailure(this.message);
}
