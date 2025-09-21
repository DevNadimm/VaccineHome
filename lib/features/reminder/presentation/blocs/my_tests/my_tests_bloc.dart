import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/reminder/data/models/pathology_model.dart';
import 'package:vaccine_home/features/reminder/data/repositories/pathology_repository.dart';

part 'my_tests_event.dart';
part 'my_tests_state.dart';

class MyTestsBloc extends Bloc<MyTestsEvent, MyTestsState> {
  MyTestsBloc() : super(MyTestsInitial()) {
    on<FetchMyTestsEvent>(_onFetchMyTests);
    on<DeleteTestEvent>(_onDeleteTest);
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

  Future<void> _onDeleteTest(
    DeleteTestEvent event,
    Emitter<MyTestsState> emit,
  ) async {
    if (state is MyTestsLoaded) {
      final currentState = state as MyTestsLoaded;

      final updatedList = List<Pathology>.from(currentState.myTests)..removeWhere((test) => test.id == event.id);

      emit(MyTestsLoaded(updatedList));

      try {
        await PathologyRepository.deleteTest(event.id);
      } catch (e) {
        emit(MyTestsLoaded(currentState.myTests));
      }
    }
  }
}
