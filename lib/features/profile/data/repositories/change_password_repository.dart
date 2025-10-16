import 'package:dio/dio.dart';
import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';

class ChangePasswordRepository {
  static Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final Map<String, dynamic> data = {
      'current_password': currentPassword,
      'new_password': newPassword,
      'new_password_confirmation': confirmPassword,
    };

    final Response res = await dioService.postRequest(
      apiEndpoints.changePassword,
      data: data,
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return true;
    } else {
      throw Exception(res.data?['message'] ?? 'Something went wrong');
    }
  }
}
