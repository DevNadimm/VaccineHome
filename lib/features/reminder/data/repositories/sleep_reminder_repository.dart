import 'package:dio/dio.dart';
import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';
import 'package:vaccine_home/core/utils/helper_functions/time_conversion_helper.dart';
import 'package:vaccine_home/features/reminder/data/models/sleep_reminder_model.dart';

class SleepReminderRepository {
  /// Add Sleep Reminder
  static Future<bool> addSleepReminder({
    required String sleepTime,
  }) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final formattedTime = TimeConversionHelper.to24Hour(sleepTime);

    final Map<String, dynamic> data = {
      'sleep_time': formattedTime,
    };

    final Response res = await dioService.postRequest(
      apiEndpoints.addSleepReminder,
      data: data,
      errorMessage: Messages.addSleepReminderFailed,
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return true;
    } else {
      throw Exception(Messages.addSleepReminderFailed);
    }
  }

  /// Fetch My Sleep Reminders
  static Future<List<SleepData>> fetchMySleepReminders() async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final Response res = await dioService.getRequest(
      apiEndpoints.mySleepReminders,
      errorMessage: Messages.mySleepRemindersFailed,
    );

    if (res.statusCode == 200) {
      final model = SleepReminderModel.fromJson(res.data);
      return model.data ?? [];
    } else {
      throw Exception(Messages.mySleepRemindersFailed);
    }
  }

  /// Update Sleep Reminder
  static Future<bool> updateSleepReminder({
    required int id,
    required String sleepTime,
  }) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final formattedTime = TimeConversionHelper.to24Hour(sleepTime);

    final Map<String, dynamic> data = {
      'sleep_time': formattedTime,
    };

    final Response res = await dioService.putRequest(
      apiEndpoints.updateSleepReminder(id),
      data: data,
      errorMessage: Messages.editSleepReminderFailed,
    );

    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception(Messages.editSleepReminderFailed);
    }
  }

  /// Delete Sleep Reminder
  static Future<bool> deleteSleepReminder(int id) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final Response res = await dioService.deleteRequest(
      apiEndpoints.deleteSleepReminder(id),
      errorMessage: Messages.deleteSleepReminderFailed,
    );

    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception(Messages.deleteSleepReminderFailed);
    }
  }
}
