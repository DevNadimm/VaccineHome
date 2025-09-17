part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent {}

class SaveProfileEvent extends EditProfileEvent {
  final String name;
  final String email;
  final String phone;
  final String? dateOfBirth;
  final String? gender;
  final String? address;
  final File? avatar;

  SaveProfileEvent({
    required this.name,
    required this.email,
    required this.phone,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.avatar,
  });
}
