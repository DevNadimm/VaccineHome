import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class TimeListCubit extends Cubit<List<TextEditingController>> {
  TimeListCubit() : super([TextEditingController()]);

  /// Add a new time field
  void addTime() {
    final newList = List<TextEditingController>.from(state);
    newList.add(TextEditingController());
    emit(newList);
  }

  /// Remove a time field at index
  void removeTime(int index) {
    if (state.length > 1) {
      final newList = List<TextEditingController>.from(state);
      newList[index].dispose();
      newList.removeAt(index);
      emit(newList);
    }
  }

  /// Update specific index with selected time
  void updateTime(int index, String time) {
    final newList = List<TextEditingController>.from(state);
    newList[index].text = time;
    emit(newList);
  }

  /// Dispose all controllers (call in dispose)
  void disposeControllers() {
    for (var controller in state) {
      controller.dispose();
    }
  }

  /// Clear all controllers
  void clearControllers() {
    emit([TextEditingController()]);
  }

  /// Print times for test
  void printTimes () {
    for (var controller in state) {
      print(controller.text);
    }
  }
}
