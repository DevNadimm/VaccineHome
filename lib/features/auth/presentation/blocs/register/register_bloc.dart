import 'package:flutter_bloc/flutter_bloc.dart';
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
        email: event.email,
        phone: event.phone,
        password: event.password,
        confirmPassword: event.confirmPassword,
      );
      emit(RegisterSuccess(model));
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
}
