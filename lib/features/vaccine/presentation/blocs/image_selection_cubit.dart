import 'package:flutter_bloc/flutter_bloc.dart';

class ImageSelectionCubit extends Cubit<int> {
  ImageSelectionCubit() : super(0);

  void selectImage(int value) {
    emit(value);
  }

  void reset() => emit(0);
}
