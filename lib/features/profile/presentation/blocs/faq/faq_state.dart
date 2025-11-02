part of 'faq_bloc.dart';

abstract class FAQState {}

class FAQInitial extends FAQState {}

class FAQLoading extends FAQState {}

class FAQLoaded extends FAQState {
  final List<Category> categories;

  FAQLoaded(this.categories);
}

class FAQFailure extends FAQState {
  final String message;

  FAQFailure(this.message);
}
