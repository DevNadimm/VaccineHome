import 'package:dio/dio.dart';
import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';
import 'package:vaccine_home/core/utils/helper_functions/time_conversion_helper.dart';
import 'package:vaccine_home/features/reminder/data/models/medication_model.dart';

class MedicationRepository {
  static final _dioService = serviceLocator<DioService>();
  static final _apiEndpoints = serviceLocator<ApiEndpoints>();

  static Future<bool> addMedication({
    required String name,
    required String type,
    required List<String> times,
    required String whenToTake,
    required String duration,
    String? startDate,
    String? endDate,
  }) async {
    final List<String> convertedTimes = times.map((t) => TimeConversionHelper.to24Hour(t)).toList();

    final Map<String, dynamic> data = {
      'medication_name': name,
      'medication_type': type,
      'duration': duration,
      'times': convertedTimes,
      'when_to_take': whenToTake,
    };

    if (duration == "Specific Date") {
      data['start_date'] = startDate;
      data['end_date'] = endDate;
    }

    final Response res = await _dioService.postRequest(
      _apiEndpoints.addMedication,
      data: data,
      errorMessage: Messages.addMedicationFailed,
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return true;
    } else {
      throw Exception(Messages.addMedicationFailed);
    }
  }

  static Future<List<Medication>> fetchMyMedications() async {
    final Response res = await _dioService.getRequest(
      _apiEndpoints.myMedications,
      errorMessage: Messages.myMedicationsFailed,
    );

    if (res.statusCode == 200) {
      final model = MedicationModel.fromJson(res.data);
      return model.data ?? [];
    } else {
      throw Exception(Messages.myMedicationsFailed);
    }
  }

  static Future<bool> deleteMedication(int id) async {
    final Response res = await _dioService.deleteRequest(
      _apiEndpoints.deleteMedication(id),
      errorMessage: Messages.deleteMedicationFailed,
    );

    if (res.statusCode == 200 || res.statusCode == 204) {
      return true;
    } else {
      throw Exception(Messages.deleteMedicationFailed);
    }
  }

  static Future<bool> updateMedication({
    required int id,
    required String name,
    required String type,
    required List<String> times,
    required String whenToTake,
    required String duration,
    String? startDate,
    String? endDate,
  }) async {
    final List<String> convertedTimes = times.map((t) => TimeConversionHelper.to24Hour(t)).toList();

    final Map<String, dynamic> data = {
      'medication_name': name,
      'medication_type': type,
      'duration': duration,
      'times': convertedTimes,
      'when_to_take': whenToTake,
    };

    if (duration == "Specific Date") {
      data['start_date'] = startDate;
      data['end_date'] = endDate;
    }

    final Response res = await _dioService.putRequest(
      _apiEndpoints.updateMedication(id),
      data: data,
      errorMessage: Messages.editMedicationFailed,
    );

    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception(Messages.editMedicationFailed);
    }
  }
}
