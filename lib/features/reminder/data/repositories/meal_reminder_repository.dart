import 'package:dio/dio.dart';
import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';
import 'package:vaccine_home/core/utils/helper_functions/time_conversion_helper.dart';
import 'package:vaccine_home/features/reminder/data/models/meal_reminder_model.dart';

class MealReminderRepository {
  /// Add Meal Reminder
  static Future<bool> addMealReminder({
    required String mealDescription,
    required List<String> mealTimes,
  }) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    // Convert all times to 24-hour format
    final List<String> convertedTimes = mealTimes.map((t) => TimeConversionHelper.to24Hour(t)).toList();

    final Map<String, dynamic> data = {
      'meal_description': mealDescription,
      'meal_times': convertedTimes,
    };

    final Response res = await dioService.postRequest(
      apiEndpoints.addMealReminder,
      data: data,
      errorMessage: Messages.addMealReminderFailed,
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return true;
    } else {
      throw Exception(Messages.addMealReminderFailed);
    }
  }

  /// Fetch My Meal Reminders
  static Future<List<MealData>> fetchMyMealReminders() async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final Response res = await dioService.getRequest(
      apiEndpoints.myMealReminders,
      errorMessage: Messages.myMealReminderFailed,
    );

    if (res.statusCode == 200) {
      final model = MealReminderModel.fromJson(res.data);
      return model.data ?? [];
    } else {
      throw Exception(Messages.myMealReminderFailed);
    }
  }

  /// Delete Meal Reminder
  static Future<bool> deleteMealReminder(int id) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final Response res = await dioService.deleteRequest(
      apiEndpoints.deleteMealReminder(id),
      errorMessage: Messages.deleteMealReminderFailed,
    );

    if (res.statusCode == 200 || res.statusCode == 204) {
      return true;
    } else {
      throw Exception(Messages.deleteMealReminderFailed);
    }
  }

  /// Update Meal Reminder
  static Future<bool> updateMealReminder({
    required int id,
    required String mealDescription,
    required List<String> mealTimes,
  }) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    // Convert all times to 24-hour format
    final List<String> convertedTimes = mealTimes.map((t) => TimeConversionHelper.to24Hour(t)).toList();

    final Map<String, dynamic> data = {
      'meal_description': mealDescription,
      'meal_times': convertedTimes,
    };

    final Response res = await dioService.putRequest(
      apiEndpoints.updateMealReminder(id),
      data: data,
      errorMessage: Messages.editMealReminderFailed,
    );

    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception(Messages.editMealReminderFailed);
    }
  }
}
