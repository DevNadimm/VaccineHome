part of 'feedback_bloc.dart';

abstract class FeedbackState {}

class FeedbackInitial extends FeedbackState {}

class FeedbackLoading extends FeedbackState {}

class FeedbackLoaded extends FeedbackState {
  final List<FeedbackData> feedbacks;

  FeedbackLoaded(this.feedbacks);
}

class FeedbackFailure extends FeedbackState {
  final String message;

  FeedbackFailure(this.message);
}

class SubmitFeedbackLoading extends FeedbackState {}

class SubmitFeedbackFailure extends FeedbackState {
  final String message;

  SubmitFeedbackFailure(this.message);
}

class SubmitFeedbackSuccess extends FeedbackState {}
