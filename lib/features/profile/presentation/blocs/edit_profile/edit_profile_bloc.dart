import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/core/utils/helper_functions/exception_formatter.dart';
import 'package:vaccine_home/features/profile/data/models/edit_profile_model.dart';
import 'package:vaccine_home/features/profile/data/repositories/edit_profile_repository.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    on<SaveProfileEvent>(_onSaveProfile);
  }

  Future<void> _onSaveProfile(
    SaveProfileEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(EditProfileLoading());
    try {
      final model = await EditProfileRepository.editProfile(
        name: event.name,
        email: event.email,
        phone: event.phone,
        gender: event.gender,
        dateOfBirth: event.dateOfBirth,
        address: event.address,
        avatar: event.avatar,
      );
      emit(EditProfileSuccess(model));
    } catch (e) {
      emit(EditProfileFailure(ExceptionFormatter.format(e)));
    }
  }
}
