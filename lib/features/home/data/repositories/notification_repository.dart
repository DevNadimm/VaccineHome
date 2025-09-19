import 'package:dio/dio.dart';
import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';
import 'package:vaccine_home/features/home/data/models/notification_model.dart';

class NotificationRepository {
  static Future<NotificationModel> fetchNotifications() async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final Response res = await dioService.getRequest(
      apiEndpoints.notifications,
      errorMessage: Messages.fetchNotificationsFailed,
    );

    if (res.statusCode == 200) {
      return NotificationModel.fromJson(res.data);
    } else {
      throw Exception(Messages.fetchNotificationsFailed);
    }
  }
}
