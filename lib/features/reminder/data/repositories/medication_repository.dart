import 'package:dio/dio.dart';
import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';
import 'package:vaccine_home/core/utils/helper_functions/time_conversion_helper.dart';

class MedicationRepository {
  static Future<bool> addMedication({
    required String name,
    required String type,
    required List<String> times,
    required String whenToTake,
  }) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    // Convert all times to 24-hour format
    final List<String> convertedTimes = times.map((t) => TimeConversionHelper.to24Hour(t)).toList();

    final Map<String, dynamic> data = {
      'medication_name': name,
      'medication_type': type,
      'times': convertedTimes,
      'when_to_take': whenToTake,
    };

    final Response res = await dioService.postRequest(
      apiEndpoints.addMedication,
      data: data,
      errorMessage: Messages.addMedicationFailed,
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return true;
    } else {
      throw Exception(Messages.addMedicationFailed);
    }
  }
}
