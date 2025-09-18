import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/vaccine/data/models/vaccine_product_model.dart';
import 'package:vaccine_home/features/vaccine/data/repositories/vaccine_product_repository.dart';

part 'vaccine_product_event.dart';
part 'vaccine_product_state.dart';

class VaccineProductBloc extends Bloc<VaccineProductEvent, VaccineProductState> {
  VaccineProductBloc() : super(VaccineProductInitial()) {
    on<FetchVaccineProducts>(_onFetchVaccineProducts);
  }

  Future<void> _onFetchVaccineProducts(
    FetchVaccineProducts event,
    Emitter<VaccineProductState> emit,
  ) async {
    emit(VaccineProductLoading());
    try {
      final res = await VaccineProductRepository.fetchProducts();
      emit(VaccineProductSuccess(res));
    } catch (e) {
      emit(VaccineProductFailure(e.toString()));
    }
  }
}
