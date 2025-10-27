import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/reminder/data/models/menstrual_cycle_alert_model.dart';
import 'package:vaccine_home/features/reminder/data/repositories/menstrual_cycle_alert_repository.dart';

part 'my_menstrual_cycle_alerts_event.dart';
part 'my_menstrual_cycle_alerts_state.dart';

class MyMenstrualCycleAlertsBloc extends Bloc<MyMenstrualCycleAlertsEvent, MyMenstrualCycleAlertsState> {
  MyMenstrualCycleAlertsBloc() : super(MyMenstrualCycleAlertsInitial()) {
    on<FetchMyMenstrualCycleAlertsEvent>(_onFetchMyMenstrualCycleAlerts);
    on<DeleteMenstrualCycleAlertEvent>(_onDeleteMenstrualCycleAlert);
  }

  Future<void> _onFetchMyMenstrualCycleAlerts(
    FetchMyMenstrualCycleAlertsEvent event,
    Emitter<MyMenstrualCycleAlertsState> emit,
  ) async {
    emit(MyMenstrualCycleAlertsLoading());
    try {
      final myMenstrualCycleAlerts = await MenstrualCycleAlertRepository.fetchMyMenstrualCycleAlerts();
      emit(MyMenstrualCycleAlertsLoaded(myMenstrualCycleAlerts));
    } catch (e) {
      emit(MyMenstrualCycleAlertsFailure(e.toString()));
    }
  }

  Future<void> _onDeleteMenstrualCycleAlert(
    DeleteMenstrualCycleAlertEvent event,
    Emitter<MyMenstrualCycleAlertsState> emit,
  ) async {
    if (state is MyMenstrualCycleAlertsLoaded) {
      final currentState = state as MyMenstrualCycleAlertsLoaded;

      final updatedList = List<MenstrualCycleData>.from(currentState.myMenstrualCycleAlerts)..removeWhere((menstrualCycle) => menstrualCycle.id == event.id);

      emit(MyMenstrualCycleAlertsLoaded(updatedList));

      try {
        await MenstrualCycleAlertRepository.deleteMenstrualCycleAlert(event.id);
      } catch (e) {
        emit(DeleteMenstrualCycleAlertFailure());
        emit(MyMenstrualCycleAlertsLoaded(currentState.myMenstrualCycleAlerts));
      }
    }
  }
}
