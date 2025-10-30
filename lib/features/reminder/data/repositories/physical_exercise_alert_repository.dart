import 'package:dio/dio.dart';
import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';
import 'package:vaccine_home/features/reminder/data/models/physical_exercise_alert_model.dart';

class PhysicalExerciseAlertRepository {
  /// Add Physical Exercise Alert
  static Future<bool> addPhysicalExerciseAlert({
    required String exerciseName,
    required String duration,
    required String time,
    required String startDate,
    required String endDate,
  }) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final Map<String, dynamic> data = {
      'exercise_name': exerciseName,
      'duration': duration,
      'time': time,
      'start_date': startDate,
      'end_date': endDate,
    };

    final Response res = await dioService.postRequest(
      apiEndpoints.addPhysicalExerciseAlert,
      data: data,
      errorMessage: Messages.addPhysicalExerciseAlertFailed,
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return true;
    } else {
      throw Exception(Messages.addPhysicalExerciseAlertFailed);
    }
  }

  /// Fetch My Physical Exercise Alerts
  static Future<List<ExerciseData>> fetchMyPhysicalExerciseAlerts() async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final Response res = await dioService.getRequest(
      apiEndpoints.myPhysicalExerciseAlerts,
      errorMessage: Messages.myPhysicalExerciseAlertsFailed,
    );

    if (res.statusCode == 200) {
      final model = PhysicalExerciseAlertModel.fromJson(res.data);
      return model.data ?? [];
    } else {
      throw Exception(Messages.myPhysicalExerciseAlertsFailed);
    }
  }

  /// Update Physical Exercise Alert
  static Future<bool> updatePhysicalExerciseAlert({
    required int id,
    required String exerciseName,
    required String duration,
    required String time,
    required String startDate,
    required String endDate,
  }) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final Map<String, dynamic> data = {
      'exercise_name': exerciseName,
      'duration': duration,
      'time': time,
      'start_date': startDate,
      'end_date': endDate,
    };

    final Response res = await dioService.putRequest(
      apiEndpoints.updatePhysicalExerciseAlert(id),
      data: data,
      errorMessage: Messages.editPhysicalExerciseAlertFailed,
    );

    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception(Messages.editPhysicalExerciseAlertFailed);
    }
  }

  /// Delete Physical Exercise Alert
  static Future<bool> deletePhysicalExerciseAlert(int id) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final Response res = await dioService.deleteRequest(
      apiEndpoints.deletePhysicalExerciseAlert(id),
      errorMessage: Messages.deletePhysicalExerciseAlertFailed,
    );

    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception(Messages.deletePhysicalExerciseAlertFailed);
    }
  }
}
