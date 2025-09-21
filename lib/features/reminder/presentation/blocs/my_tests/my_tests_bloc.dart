import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/reminder/data/models/pathology_model.dart';
import 'package:vaccine_home/features/reminder/data/repositories/pathology_repository.dart';

part 'my_tests_event.dart';
part 'my_tests_state.dart';

class MyTestsBloc extends Bloc<MyTestsEvent, MyTestsState> {
  MyTestsBloc() : super(MyTestsInitial()) {
    on<MyTestsEvent>(_onFetchMyTests);
  }

  Future<void> _onFetchMyTests(
    MyTestsEvent event,
    Emitter<MyTestsState> emit,
  ) async {
    emit(MyTestsLoading());
    try {
      final myTests = await PathologyRepository.fetchMyTests();
      emit(MyTestsLoaded(myTests));
    } catch (e) {
      emit(MyTestsFailure(e.toString()));
    }
  }
}
