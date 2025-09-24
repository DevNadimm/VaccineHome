import 'package:dio/dio.dart';
import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';
import 'package:vaccine_home/features/profile/data/models/vaccine_order_model.dart';

class VaccineOrderHistoryRepository {
  static Future<List<VaccineOrderData>> getOrderHistory() async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final Response res = await dioService.getRequest(
      apiEndpoints.getVaccineOrderHistory,
      errorMessage: Messages.orderFetchFailed,
    );

    if (res.statusCode == 200) {
      final data = res.data['data'];
      if (data != null && data['orders'] != null) {
        final responseModel = VaccineOrderModel.fromJson(data);
        return responseModel.orders ?? [];
      }
      return [];
    } else {
      throw Exception(Messages.orderFetchFailed);
    }
  }
}
