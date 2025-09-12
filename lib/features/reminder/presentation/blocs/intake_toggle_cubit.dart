import 'package:flutter_bloc/flutter_bloc.dart';

class IntakeToggleCubit extends Cubit<String> {
  IntakeToggleCubit() : super('Before Meals');

  void toggle() => emit(state == 'Before Meals' ? 'After Meals' : 'Before Meals');
  void reset() => emit('Before Meals');
}
