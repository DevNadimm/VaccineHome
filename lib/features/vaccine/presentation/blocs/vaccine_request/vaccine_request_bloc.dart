import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/vaccine/data/repositories/vaccine_request_repository.dart';

part 'vaccine_request_event.dart';
part 'vaccine_request_state.dart';

class VaccineRequestBloc extends Bloc<VaccineRequestEvent, VaccineRequestState> {
  VaccineRequestBloc() : super(VaccineRequestInitial()) {
    on<SendVaccineRequestEvent>(_onSendVaccineRequest);
  }

  Future<void> _onSendVaccineRequest(
    SendVaccineRequestEvent event,
    Emitter<VaccineRequestState> emit,
  ) async {
    emit(VaccineRequestLoading());
    try {
      final res = await VaccineRequestRepository.requestVaccine(
        phone: event.phone,
        address: event.address,
        productId: event.productId,
      );
      if (res) {
        emit(VaccineRequestSuccess());
      } else {
        emit(VaccineRequestFailure("Unknown error occurred"));
      }
    } catch (e) {
      emit(VaccineRequestFailure(e.toString()));
    }
  }
}
