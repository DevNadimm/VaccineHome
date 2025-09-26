import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/vaccine/data/models/vaccine_recommendations_model.dart';
import 'package:vaccine_home/features/vaccine/data/repositories/vaccine_recommendations_repository.dart';

part 'vaccine_recommendation_event.dart';
part 'vaccine_recommendation_state.dart';

class VaccineRecommendationBloc extends Bloc<VaccineRecommendationEvent, VaccineRecommendationState> {
  VaccineRecommendationBloc() : super(VaccineRecommendationInitial()) {
    on<FetchVaccineRecommendationEvent>(_onFetchVaccineRecommendations);
  }

  Future<void> _onFetchVaccineRecommendations(
    FetchVaccineRecommendationEvent event,
    Emitter<VaccineRecommendationState> emit,
  ) async {
    emit(VaccineRecommendationLoading());
    try {
      final recommendations = await VaccineRecommendationsRepository.fetchRecommendations();
      emit(VaccineRecommendationLoaded(recommendations));
    } catch (e) {
      emit(VaccineRecommendationFailure(e.toString()));
    }
  }
}
