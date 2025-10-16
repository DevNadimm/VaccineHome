import 'package:dio/dio.dart';
import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';

class VaccineOrderRepository {
  static Future<bool> orderVaccine({
    required String phone,
    required String address,
    required int productId,
  }) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final Map<String, dynamic> data = {
      'phone': phone,
      'address': address,
      'vaccine_product_id': productId,
    };

    final Response res = await dioService.postRequest(
      apiEndpoints.vaccineRequest,
      data: data,
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return true;
    } else {
      throw Exception(res.data['message']);
    }
  }
}
