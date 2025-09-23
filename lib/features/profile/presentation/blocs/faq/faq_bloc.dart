import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/profile/data/models/faq_model.dart';
import 'package:vaccine_home/features/profile/data/repositories/faq_repository.dart';

part 'faq_event.dart';
part 'faq_state.dart';

class FAQBloc extends Bloc<FAQEvent, FAQState> {
  FAQBloc() : super(FAQInitial()) {
    on<FetchFAQEvent>(_onFetchFAQs);
  }

  Future<void> _onFetchFAQs(
    FetchFAQEvent event,
    Emitter<FAQState> emit,
  ) async {
    emit(FAQLoading());
    try {
      final res = await FAQRepository.getFaqs();
      emit(FAQLoaded(res));
    } catch (e) {
      emit(FAQFailure(e.toString()));
    }
  }
}
