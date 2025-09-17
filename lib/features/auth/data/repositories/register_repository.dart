import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/services/app_preferences.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';
import 'package:vaccine_home/features/auth/data/models/register_model.dart';

class RegisterRepository {
  static Future<RegisterModel> registerUser({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final data = {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
      "password_confirmation": confirmPassword,
    };

    final res = await dioService.postRequest(
      apiEndpoints.registerUser,
      data: data,
      errorMessage: Messages.registrationFailed,
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      final model = RegisterModel.fromJson(res.data);

      dioService.setAuthToken(model.accessToken ?? '');
      await AppPreferences.setAccessToken(model.accessToken ?? '');

      return model;
    } else {
      throw Exception(Messages.registrationFailed);
    }
  }
}
