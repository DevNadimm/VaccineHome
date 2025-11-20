import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/core/utils/helper_functions/exception_formatter.dart';
import 'package:vaccine_home/features/auth/data/repositories/forgot_password_repository.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<SendForgotPasswordPinEvent>(_onSendPin);
  }

  Future<void> _onSendPin(
    SendForgotPasswordPinEvent event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(ForgotPasswordLoading());

    try {
      final res = await ForgotPasswordRepository.sendPin(phone: event.phone);
      if (res) emit(ForgotPasswordSuccess());
    } catch (e) {
      emit(ForgotPasswordFailure(ExceptionFormatter.format(e)));
    }
  }
}
