import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/core/utils/helper_functions/exception_formatter.dart';
import 'package:vaccine_home/features/auth/data/models/login_model.dart';
import 'package:vaccine_home/features/auth/data/repositories/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginUserEvent>(_onLoginUser);
  }

  Future<void> _onLoginUser(
    LoginUserEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      final model = await LoginRepository.loginUser(
        phone: event.phone,
        password: event.password,
      );
      emit(LoginSuccess(model));
    } catch (e) {
      emit(LoginFailure(ExceptionFormatter.format(e)));
    }
  }
}
