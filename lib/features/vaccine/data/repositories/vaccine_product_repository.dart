import 'package:dio/dio.dart';
import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';
import 'package:vaccine_home/features/vaccine/data/models/vaccine_product_model.dart';

class VaccineProductRepository {
  static Future<List<VaccineProduct>> fetchProducts() async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final Response res = await dioService.getRequest(
      apiEndpoints.products,
      errorMessage: Messages.fetchProductsFailed,
    );

    if (res.statusCode == 200) {
      final model = VaccineProductModel.fromJson(res.data);
      return model.data?.vaccineProducts ?? [];
    } else {
      throw Exception(Messages.fetchProductsFailed);
    }
  }
}
