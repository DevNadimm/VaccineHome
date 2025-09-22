part of 'notification_bloc.dart';

abstract class NotificationEvent {}

class FetchNotificationsEvent extends NotificationEvent {}

class ReadNotificationsEvent extends NotificationEvent {
  final String id;

  ReadNotificationsEvent(this.id);
}

class ReadAllNotificationsEvent extends NotificationEvent {}

class DeleteAllNotificationsEvent extends NotificationEvent {}
