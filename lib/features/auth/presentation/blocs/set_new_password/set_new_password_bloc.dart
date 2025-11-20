import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/core/utils/helper_functions/exception_formatter.dart';
import 'package:vaccine_home/features/auth/data/repositories/forgot_password_repository.dart';

part 'set_new_password_event.dart';
part 'set_new_password_state.dart';

class SetNewPasswordBloc extends Bloc<SetNewPasswordEvent, SetNewPasswordState> {
  SetNewPasswordBloc() : super(SetNewPasswordInitial()) {
    on<SetPasswordEvent>(_onSetPassword);
  }

  Future<void> _onSetPassword(
    SetPasswordEvent event,
    Emitter<SetNewPasswordState> emit,
  ) async {
    emit(SetNewPasswordLoading());

    try {
      final res = await ForgotPasswordRepository.setNewPassword(
        phone: event.phone,
        pin: event.pin,
        password: event.newPassword,
        confirmPassword: event.confirmNewPassword,
      );

      if (res) emit(SetNewPasswordSuccess());
    } catch (e) {
      emit(SetNewPasswordFailure(ExceptionFormatter.format(e)));
    }
  }
}
