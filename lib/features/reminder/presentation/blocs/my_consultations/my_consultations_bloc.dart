import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/reminder/data/models/dr_consultancy_model.dart';
import 'package:vaccine_home/features/reminder/data/repositories/dr_consultancy_repository.dart';

part 'my_consultations_event.dart';
part 'my_consultations_state.dart';

class MyConsultationsBloc extends Bloc<MyConsultationsEvent, MyConsultationsState> {
  MyConsultationsBloc() : super(MyConsultationsInitial()) {
    on<FetchMyConsultationsEvent>(_onFetchMyConsultations);
    on<DeleteConsultationEvent>(_onDeleteConsultation);
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

  Future<void> _onDeleteConsultation(
    DeleteConsultationEvent event,
    Emitter<MyConsultationsState> emit,
  ) async {
    if (state is MyConsultationsLoaded) {
      final currentState = state as MyConsultationsLoaded;

      final updatedList = List<DrConsultancy>.from(currentState.myConsultations)..removeWhere((med) => med.id == event.id);

      emit(MyConsultationsLoaded(updatedList));

      try {
        await DrConsultancyRepository.deleteConsultation(event.id);
      } catch (e) {
        emit(DeleteConsultationFailure());
        emit(MyConsultationsLoaded(currentState.myConsultations));
      }
    }
  }
}
