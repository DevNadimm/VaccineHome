import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/profile/data/models/feedback_model.dart';
import 'package:vaccine_home/features/profile/data/repositories/feedback_repository.dart';

part 'feedback_event.dart';
part 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  FeedbackBloc() : super(FeedbackInitial()) {
    on<FetchFeedbacksEvent>(_onFetchFeedbacks);
    on<SubmitFeedbackEvent>(_onSubmitFeedback);
  }

  Future<void> _onFetchFeedbacks(
    FetchFeedbacksEvent event,
    Emitter<FeedbackState> emit,
  ) async {
    emit(FeedbackLoading());
    try {
      final feedbacks = await FeedbackRepository.getFeedbacks();
      emit(FeedbackLoaded(feedbacks));
    } catch (e) {
      emit(FeedbackFailure(e.toString()));
    }
  }

  Future<void> _onSubmitFeedback(
    SubmitFeedbackEvent event,
    Emitter<FeedbackState> emit,
  ) async {
    emit(SubmitFeedbackLoading());
    try {
      final success = await FeedbackRepository.submitFeedback(
        feedback: event.feedbackMessage,
        rating: event.rating,
        experience: event.experience,
        feedbackType: event.feedbackType,
        improvementArea: event.improvementArea,
      );

      if (success) {
        emit(SubmitFeedbackSuccess());
        final feedbacks = await FeedbackRepository.getFeedbacks();
        emit(FeedbackLoaded(feedbacks));
      } else {
        emit(SubmitFeedbackFailure("Failed to submit feedback"));
      }
    } catch (e) {
      emit(SubmitFeedbackFailure(e.toString()));
    }
  }
}
