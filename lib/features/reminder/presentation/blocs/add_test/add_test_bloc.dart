import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/reminder/data/repositories/pathology_repository.dart';

part 'add_test_event.dart';
part 'add_test_state.dart';

class AddTestBloc extends Bloc<AddTestEvent, AddTestState> {
  AddTestBloc() : super(AddTestInitial()) {
    on<SaveAddTestEvent>(_onSaveAddTest);
  }

  Future<void> _onSaveAddTest(
    SaveAddTestEvent event,
    Emitter<AddTestState> emit,
  ) async {
    emit(AddTestLoading());
    try {
      final res = await PathologyRepository.addTest(
        testName: event.testName,
        nextTestDate: event.nextTestDate,
        nextTestTime: event.nextTestTime,
        description: event.description,
      );
      if (res) {
        emit(AddTestSuccess());
      } else {
        emit(AddTestFailure("Unknown error occurred"));
      }
    } catch (e) {
      emit(AddTestFailure(e.toString()));
    }
  }
}
