import 'package:flutter_bloc/flutter_bloc.dart';

class RatingCubit extends Cubit<int> {
  RatingCubit() : super(5);

  void setRating(int value) {
    if (value >= 1 && value <= 5) {
      emit(value);
    }
  }

  void reset() => emit(5);
}
