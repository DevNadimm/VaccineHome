import 'package:dio/dio.dart';
import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';
import 'package:vaccine_home/core/utils/helper_functions/time_conversion_helper.dart';

class OnlineVaccineAppointmentRepository {
  static Future<bool> bookAppointment({
    required String name,
    required String phone,
    required String date,
    required String time,
  }) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final formattedTime = TimeConversionHelper.to24Hour(time);

    final data = {
      "name": name,
      "phone": phone,
      "appointment_date": date,
      "appointment_time": formattedTime
    };

    final Response res = await dioService.postRequest(
      apiEndpoints.bookVaccineAppointment,
      data: data,
      errorMessage: Messages.bookVaccineAppointmentFailed,
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return true;
    } else {
      throw Exception(Messages.bookVaccineAppointmentFailed);
    }
  }
}
