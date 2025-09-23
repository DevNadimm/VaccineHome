import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/vaccine/data/repositories/vaccine_order_repository.dart';

part 'vaccine_order_event.dart';
part 'vaccine_order_state.dart';

class VaccineOrderBloc extends Bloc<VaccineOrderEvent, VaccineOrderState> {
  VaccineOrderBloc() : super(VaccineOrderInitial()) {
    on<SendVaccineOrderEvent>(_onSendVaccineOrder);
  }

  Future<void> _onSendVaccineOrder(
    SendVaccineOrderEvent event,
    Emitter<VaccineOrderState> emit,
  ) async {
    emit(VaccineOrderLoading());
    try {
      final res = await VaccineOrderRepository.orderVaccine(
        phone: event.phone,
        address: event.address,
        productId: event.productId,
      );
      if (res) {
        emit(VaccineOrderSuccess());
      } else {
        emit(VaccineOrderFailure("Unknown error occurred"));
      }
    } catch (e) {
      emit(VaccineOrderFailure(e.toString()));
    }
  }
}
