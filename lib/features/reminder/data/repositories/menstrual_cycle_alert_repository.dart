import 'package:dio/dio.dart';
import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';
import 'package:vaccine_home/features/reminder/data/models/menstrual_cycle_alert_model.dart';

class MenstrualCycleAlertRepository {
  /// Add Menstrual Cycle Alert
  static Future<bool> addMenstrualCycleAlert({
    required String lastCycleStartDate,
    required String lastCycleEndDate,
  }) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final Map<String, dynamic> data = {
      'last_cycle_start_date': lastCycleStartDate,
      'last_cycle_end_date': lastCycleEndDate,
    };

    final Response res = await dioService.postRequest(
      apiEndpoints.addMenstrualCycleAlert,
      data: data,
      errorMessage: Messages.addMenstrualCycleAlertFailed,
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return true;
    } else {
      throw Exception(Messages.addMenstrualCycleAlertFailed);
    }
  }

  /// Fetch My Menstrual Cycle Alerts
  static Future<List<MenstrualCycleData>> fetchMyMenstrualCycleAlerts() async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final Response res = await dioService.getRequest(
      apiEndpoints.myMenstrualCycleAlerts,
      errorMessage: Messages.myMenstrualCycleAlertsFailed,
    );

    if (res.statusCode == 200) {
      final model = MenstrualCycleAlertModel.fromJson(res.data);
      return model.data ?? [];
    } else {
      throw Exception(Messages.myMenstrualCycleAlertsFailed);
    }
  }

  /// Update Menstrual Cycle Alert
  static Future<bool> updateMenstrualCycleAlert({
    required int id,
    required String lastCycleStartDate,
    required String lastCycleEndDate,
  }) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final Map<String, dynamic> data = {
      'last_cycle_start_date': lastCycleStartDate,
      'last_cycle_end_date': lastCycleEndDate,
    };

    final Response res = await dioService.putRequest(
      apiEndpoints.updateMenstrualCycleAlert(id),
      data: data,
      errorMessage: Messages.editMenstrualCycleAlertFailed,
    );

    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception(Messages.editMenstrualCycleAlertFailed);
    }
  }

  /// Delete Menstrual Cycle Alert
  static Future<bool> deleteMenstrualCycleAlert(int id) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final Response res = await dioService.deleteRequest(
      apiEndpoints.deleteMenstrualCycleAlert(id),
      errorMessage: Messages.deleteMenstrualCycleAlertFailed,
    );

    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception(Messages.deleteMenstrualCycleAlertFailed);
    }
  }
}
