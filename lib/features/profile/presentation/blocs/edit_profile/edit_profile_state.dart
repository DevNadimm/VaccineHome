part of 'edit_profile_bloc.dart';

abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {
  final EditProfileModel model;

  EditProfileSuccess(this.model);
}

class EditProfileFailure extends EditProfileState {
  final String message;

  EditProfileFailure(this.message);
}
