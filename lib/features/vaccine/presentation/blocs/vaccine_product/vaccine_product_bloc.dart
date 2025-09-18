import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'vaccine_product_event.dart';
part 'vaccine_product_state.dart';

class VaccineProductBloc extends Bloc<VaccineProductEvent, VaccineProductState> {
  VaccineProductBloc() : super(VaccineProductInitial()) {
    on<VaccineProductEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
