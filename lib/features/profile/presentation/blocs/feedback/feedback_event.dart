part of 'feedback_bloc.dart';

abstract class FeedbackEvent {}

class FetchFeedbacksEvent extends FeedbackEvent {}

class SubmitFeedbackEvent extends FeedbackEvent {
  final String feedbackMessage;
  final int rating;
  final String experience;
  final String feedbackType;
  final String improvementArea;

  SubmitFeedbackEvent({
    required this.feedbackMessage,
    required this.rating,
    required this.experience,
    required this.feedbackType,
    required this.improvementArea,
  });
}
