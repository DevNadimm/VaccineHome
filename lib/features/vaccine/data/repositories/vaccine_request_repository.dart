import 'package:dio/dio.dart';
import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';

class VaccineRequestRepository {
  static Future<bool> requestVaccine({
    required int divisionId,
    required int policeStationId,
    required int productId,
    required String phone,
  }) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final Map<String, dynamic> data = {
      'division_id': divisionId,
      'police_station_id': policeStationId,
      'product_id': productId,
      'phone': phone,
    };

    final Response res = await dioService.postRequest(
      apiEndpoints.vaccineRequest,
      data: data,
      errorMessage: Messages.vaccineRequestFailed,
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return true;
    } else {
      throw Exception(Messages.vaccineRequestFailed);
    }
  }
}
