import 'package:flutter_bloc/flutter_bloc.dart';

List<String> durationType = ["Regular", "Specific Date"];

class DurationTypeCubit extends Cubit<String> {
  DurationTypeCubit() : super(durationType[0]);

  void setDurationType(String type) => emit(type);

  void reset() => emit(durationType[0]);
}
