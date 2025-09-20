import 'package:dio/dio.dart';
import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';
import 'package:vaccine_home/core/utils/helper_functions/time_conversion_helper.dart';

class DrConsultancyRepository {
  static Future<bool> addConsultation({
    required String doctorName,
    required String nextConsultationDate,
    required String nextConsultationTime,
    required String address,
  }) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    // Convert time to 24-hour format
    final String convertedTime = TimeConversionHelper.to24Hour(nextConsultationTime);

    final Map<String, dynamic> data = {
      'doctor_name': doctorName,
      'next_consultation_date': nextConsultationDate,
      'next_consultation_time': convertedTime,
      'address': address,
    };

    final Response res = await dioService.postRequest(
      apiEndpoints.addConsultation,
      data: data,
      errorMessage: Messages.addConsultationFailed,
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return true;
    } else {
      throw Exception(Messages.addConsultationFailed);
    }
  }
}
