import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/profile/data/models/vaccine_order_model.dart';
import 'package:vaccine_home/features/profile/data/repositories/vaccine_order_history_repository.dart';

part 'vaccine_order_history_event.dart';
part 'vaccine_order_history_state.dart';

class VaccineOrderHistoryBloc extends Bloc<VaccineOrderHistoryEvent, VaccineOrderHistoryState> {
  VaccineOrderHistoryBloc() : super(VaccineOrderHistoryInitial()) {
    on<FetchVaccineOrderHistoryEvent>(_onFetchVaccineOrderHistory);
  }

  Future<void> _onFetchVaccineOrderHistory(
    FetchVaccineOrderHistoryEvent event,
    Emitter<VaccineOrderHistoryState> emit,
  ) async {
    emit(VaccineOrderHistoryLoading());
    try {
      final res = await VaccineOrderHistoryRepository.getOrderHistory();
      emit(VaccineOrderHistoryLoaded(res));
    } catch (e) {
      emit(VaccineOrderHistoryFailure(e.toString()));
    }
  }
}
