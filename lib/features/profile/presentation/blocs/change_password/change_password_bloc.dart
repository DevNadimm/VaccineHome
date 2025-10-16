import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/core/utils/helper_functions/exception_formatter.dart';
import 'package:vaccine_home/features/profile/data/repositories/change_password_repository.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(ChangePasswordInitial()) {
    on<SaveChangePasswordEvent>(_onSaveChangePassword);
  }

  Future<void> _onSaveChangePassword(
    SaveChangePasswordEvent event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(ChangePasswordLoading());
    try {
      final res = await ChangePasswordRepository.changePassword(
        currentPassword: event.currentPass,
        newPassword: event.newPass,
        confirmPassword: event.confirmNewPass,
      );
      if (res) emit(ChangePasswordSuccess());
    } catch (e) {
      emit(ChangePasswordFailure(ExceptionFormatter.format(e)));
    }
  }
}
