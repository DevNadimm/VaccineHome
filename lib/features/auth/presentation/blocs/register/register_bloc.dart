import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/core/utils/helper_functions/exception_formatter.dart';
import 'package:vaccine_home/features/auth/data/models/register_model.dart';
import 'package:vaccine_home/features/auth/data/repositories/register_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterUserEvent>(_onRegisterUser);
  }

  Future<void> _onRegisterUser(
    RegisterUserEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    try {
      final model = await RegisterRepository.registerUser(
        name: event.name,
        phone: event.phone,
        dateOfBirth: event.dateOfBirth,
        password: event.password,
        confirmPassword: event.confirmPassword,
      );
      emit(RegisterSuccess(model));
    } catch (e) {
      emit(RegisterFailure(ExceptionFormatter.format(e)));
    }
  }
}
