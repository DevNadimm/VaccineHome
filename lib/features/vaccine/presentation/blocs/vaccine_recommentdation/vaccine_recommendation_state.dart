part of 'vaccine_recommendation_bloc.dart';

abstract class VaccineRecommendationState {}

class VaccineRecommendationInitial extends VaccineRecommendationState {}

class VaccineRecommendationLoading extends VaccineRecommendationState {}

class VaccineRecommendationLoaded extends VaccineRecommendationState {
  final List<VaccineRecommendation> recommendations;

  VaccineRecommendationLoaded(this.recommendations);
}

class VaccineRecommendationFailure extends VaccineRecommendationState {
  final String message;

  VaccineRecommendationFailure(this.message);
}
