import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/core/utils/helper_functions/exception_formatter.dart';
import 'package:vaccine_home/features/auth/data/repositories/forgot_password_repository.dart';

part 'pin_verification_event.dart';
part 'pin_verification_state.dart';

class PinVerificationBloc extends Bloc<PinVerificationEvent, PinVerificationState> {
  PinVerificationBloc() : super(PinVerificationInitial()) {
    on<VerifyPinEvent>(_onVerifyPin);
  }

  Future<void> _onVerifyPin(
    VerifyPinEvent event,
    Emitter<PinVerificationState> emit,
  ) async {
    emit(PinVerificationLoading());

    try {
      final res = await ForgotPasswordRepository.verifyPin(
        email: event.email,
        pin: event.pin,
      );
      if (res) emit(PinVerificationSuccess());
    } catch (e) {
      emit(PinVerificationFailure(ExceptionFormatter.format(e)));
    }
  }
}
