import 'package:dio/dio.dart';
import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';
import 'package:vaccine_home/core/utils/helper_functions/time_conversion_helper.dart';
import 'package:vaccine_home/features/reminder/data/models/dr_consultancy_model.dart';

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

  static Future<List<DrConsultancy>> fetchMyConsultations() async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final Response res = await dioService.getRequest(
      apiEndpoints.myConsultations,
      errorMessage: Messages.myConsultationsFailed,
    );

    if (res.statusCode == 200) {
      final model = DrConsultancyModel.fromJson(res.data);
      return model.data ?? [];
    } else {
      throw Exception(Messages.myConsultationsFailed);
    }
  }
}
