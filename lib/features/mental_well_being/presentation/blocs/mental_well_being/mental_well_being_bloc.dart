import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/mental_well_being/data/models/mental_well_being_model.dart';
import 'package:vaccine_home/features/mental_well_being/data/repositories/mental_well_being_repository.dart';

part 'mental_well_being_event.dart';
part 'mental_well_being_state.dart';

class MentalWellBeingBloc extends Bloc<MentalWellBeingEvent, MentalWellBeingState> {
  MentalWellBeingBloc() : super(MentalWellBeingInitial()) {
    on<FetchMentalWellBeingEvent>(_onFetchMentalWellBeing);
  }

  Future<void> _onFetchMentalWellBeing(
    FetchMentalWellBeingEvent event,
    Emitter<MentalWellBeingState> emit,
  ) async {
    emit(MentalWellBeingLoading());
    try {
      final res = await MentalWellBeingRepository.fetchMentalWellBeings();
      emit(MentalWellBeingLoaded(res));
    } catch (e) {
      emit(MentalWellBeingFailure(e.toString()));
    }
  }
}
