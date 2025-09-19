part of 'notification_bloc.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final NotificationModel notificationModel;

  NotificationLoaded(this.notificationModel);
}

class NotificationFailure extends NotificationState {
  final String message;

  NotificationFailure(this.message);
}
