import 'package:dio/dio.dart';
import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';
import 'package:vaccine_home/core/utils/helper_functions/time_conversion_helper.dart';

class PathologyRepository {
  static Future<bool> addTest({
    required String testName,
    required String nextTestDate,
    required String nextTestTime,
    required String description,
  }) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    // Convert time to 24-hour format
    final String convertedTime = TimeConversionHelper.to24Hour(nextTestTime);

    final Map<String, dynamic> data = {
      'test_name': testName,
      'next_test_date': nextTestDate,
      'next_test_time': convertedTime,
      'description': description,
    };

    final Response res = await dioService.postRequest(
      apiEndpoints.addTest,
      data: data,
      errorMessage: Messages.addTestFailed,
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return true;
    } else {
      throw Exception(Messages.addTestFailed);
    }
  }
}
