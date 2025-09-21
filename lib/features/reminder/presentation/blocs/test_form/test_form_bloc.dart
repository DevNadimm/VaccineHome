import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/reminder/data/repositories/pathology_repository.dart';

part 'test_form_event.dart';
part 'test_form_state.dart';

class TestFormBloc extends Bloc<TestFormEvent, TestFormState> {
  TestFormBloc() : super(TestFormInitial()) {
    on<SaveTestFormEvent>(_onSaveTestForm);
  }

  Future<void> _onSaveTestForm(
    SaveTestFormEvent event,
    Emitter<TestFormState> emit,
  ) async {
    emit(TestFormLoading());
    try {
      final res = await PathologyRepository.addTest(
        testName: event.testName,
        nextTestDate: event.nextTestDate,
        nextTestTime: event.nextTestTime,
        description: event.description,
      );
      if (res) {
        emit(TestFormSuccess());
      } else {
        emit(TestFormFailure("Unknown error occurred"));
      }
    } catch (e) {
      emit(TestFormFailure(e.toString()));
    }
  }
}
