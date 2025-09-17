part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent {}

class SaveChangePasswordEvent extends ChangePasswordEvent {
  final String currentPass;
  final String newPass;
  final String confirmNewPass;

  SaveChangePasswordEvent({
    required this.currentPass,
    required this.newPass,
    required this.confirmNewPass,
  });
}
