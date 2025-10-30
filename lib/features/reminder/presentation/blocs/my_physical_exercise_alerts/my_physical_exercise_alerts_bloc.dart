import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/reminder/data/models/physical_exercise_alert_model.dart';
import 'package:vaccine_home/features/reminder/data/repositories/physical_exercise_alert_repository.dart';

part 'my_physical_exercise_alerts_event.dart';
part 'my_physical_exercise_alerts_state.dart';

class MyPhysicalExerciseAlertsBloc extends Bloc<MyPhysicalExerciseAlertsEvent, MyPhysicalExerciseAlertsState> {
  MyPhysicalExerciseAlertsBloc() : super(MyPhysicalExerciseAlertsInitial()) {
    on<FetchMyPhysicalExerciseAlertsEvent>(_onFetchMyPhysicalExerciseAlerts);
    on<DeletePhysicalExerciseAlertEvent>(_onDeletePhysicalExerciseAlert);
  }

  Future<void> _onFetchMyPhysicalExerciseAlerts(
    FetchMyPhysicalExerciseAlertsEvent event,
    Emitter<MyPhysicalExerciseAlertsState> emit,
  ) async {
    emit(MyPhysicalExerciseAlertsLoading());
    try {
      final myPhysicalExerciseAlerts = await PhysicalExerciseAlertRepository.fetchMyPhysicalExerciseAlerts();
      emit(MyPhysicalExerciseAlertsLoaded(myPhysicalExerciseAlerts));
    } catch (e) {
      emit(MyPhysicalExerciseAlertsFailure(e.toString()));
    }
  }

  Future<void> _onDeletePhysicalExerciseAlert(
    DeletePhysicalExerciseAlertEvent event,
    Emitter<MyPhysicalExerciseAlertsState> emit,
  ) async {
    if (state is MyPhysicalExerciseAlertsLoaded) {
      final currentState = state as MyPhysicalExerciseAlertsLoaded;

      final updatedList = List<ExerciseData>.from(currentState.myPhysicalExerciseAlerts)..removeWhere((exercise) => exercise.id == event.id);

      emit(MyPhysicalExerciseAlertsLoaded(updatedList));

      try {
        await PhysicalExerciseAlertRepository.deletePhysicalExerciseAlert(event.id);
      } catch (e) {
        emit(DeletePhysicalExerciseAlertFailure());
        emit(MyPhysicalExerciseAlertsLoaded(currentState.myPhysicalExerciseAlerts));
      }
    }
  }
}
