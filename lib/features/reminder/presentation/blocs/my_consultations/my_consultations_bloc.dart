import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/reminder/data/models/dr_consultancy_model.dart';
import 'package:vaccine_home/features/reminder/data/repositories/dr_consultancy_repository.dart';

part 'my_consultations_event.dart';
part 'my_consultations_state.dart';

class MyConsultationsBloc extends Bloc<MyConsultationsEvent, MyConsultationsState> {
  MyConsultationsBloc() : super(MyConsultationsInitial()) {
    on<MyConsultationsEvent>(_onFetchMyConsultations);
  }

  Future<void> _onFetchMyConsultations(
    MyConsultationsEvent event,
    Emitter<MyConsultationsState> emit,
  ) async {
    emit(MyConsultationsLoading());

    try {
      final myConsultations = await DrConsultancyRepository.fetchMyConsultations();
      emit(MyConsultationsLoaded(myConsultations));
    } catch (e) {
      emit(MyConsultationsFailure(e.toString()));
    }
  }
}
