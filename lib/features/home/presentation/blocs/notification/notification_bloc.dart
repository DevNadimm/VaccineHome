import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/home/data/models/notification_model.dart';
import 'package:vaccine_home/features/home/data/repositories/notification_repository.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<FetchNotificationsEvent>(_onFetchNotifications);
    on<ReadNotificationsEvent>(_onReadNotification);
    on<ReadAllNotificationsEvent>(_onReadAllNotifications);
    on<DeleteAllNotificationsEvent>(_onDeleteAllNotifications);
  }

  Future<void> _onFetchNotifications(
    FetchNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoading());
    try {
      final notifications = await NotificationRepository.fetchNotifications();
      emit(NotificationLoaded(notifications));
    } catch (e) {
      emit(NotificationFailure(e.toString()));
    }
  }

  Future<void> _onReadNotification(
    ReadNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final res = await NotificationRepository.markNotificationAsRead(event.id);
    if (res) {
      final notifications = await NotificationRepository.fetchNotifications();
      emit(NotificationLoaded(notifications));
    }
  }

  Future<void> _onReadAllNotifications(
    ReadAllNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final res = await NotificationRepository.markAllNotificationsAsRead();
    if (res) {
      final notifications = await NotificationRepository.fetchNotifications();
      emit(NotificationLoaded(notifications));
    }
  }

  Future<void> _onDeleteAllNotifications(
    DeleteAllNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoading());
    try {
      final res = await NotificationRepository.deleteAllNotifications();
      if (res) {
        emit(DeleteAllNotificationsSuccess());
      }
    } catch (e) {
      emit(DeleteAllNotificationsFailure());
    }
  }
}
