import 'package:dio/dio.dart';
import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';
import 'package:vaccine_home/core/utils/helper_functions/time_conversion_helper.dart';
import 'package:vaccine_home/features/reminder/data/models/water_reminder_model.dart';

class WaterReminderRepository {
  /// Add Water Reminder
  static Future<bool> addWaterReminder({
    required int totalWater,
    required List<String> waterTimes,
  }) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    // Convert all times to 24-hour format
    final List<String> convertedTimes = waterTimes.map((t) => TimeConversionHelper.to24Hour(t)).toList();

    final Map<String, dynamic> data = {
      'total_water': totalWater,
      'water_times': convertedTimes,
    };

    final Response res = await dioService.postRequest(
      apiEndpoints.addWaterReminder,
      data: data,
      errorMessage: Messages.addWaterReminderFailed,
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return true;
    } else {
      throw Exception(Messages.addWaterReminderFailed);
    }
  }

  /// Fetch My Water Reminders
  static Future<List<WaterData>> fetchMyWaterReminders() async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final Response res = await dioService.getRequest(
      apiEndpoints.myWaterReminders,
      errorMessage: Messages.myWaterReminderFailed,
    );

    if (res.statusCode == 200) {
      final model = WaterReminderModel.fromJson(res.data);
      return model.data ?? [];
    } else {
      throw Exception(Messages.myWaterReminderFailed);
    }
  }

  /// Delete Water Reminder
  static Future<bool> deleteWaterReminder(int id) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final Response res = await dioService.deleteRequest(
      apiEndpoints.deleteWaterReminder(id),
      errorMessage: Messages.deleteWaterReminderFailed,
    );

    if (res.statusCode == 200 || res.statusCode == 204) {
      return true;
    } else {
      throw Exception(Messages.deleteWaterReminderFailed);
    }
  }

  /// Update Water Reminder
  static Future<bool> updateWaterReminder({
    required int id,
    required int totalWater,
    required List<String> waterTimes,
  }) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    // Convert all times to 24-hour format
    final List<String> convertedTimes = waterTimes.map((t) => TimeConversionHelper.to24Hour(t)).toList();

    final Map<String, dynamic> data = {
      'total_water': totalWater,
      'water_times': convertedTimes,
    };

    final Response res = await dioService.putRequest(
      apiEndpoints.updateWaterReminder(id),
      data: data,
      errorMessage: Messages.editWaterReminderFailed,
    );

    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception(Messages.editWaterReminderFailed);
    }
  }
}
