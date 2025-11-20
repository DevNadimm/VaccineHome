import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/services/app_preferences.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';
import 'package:vaccine_home/core/utils/helper_functions/date_conversion_helper.dart';
import 'package:vaccine_home/features/auth/data/models/register_model.dart';

class RegisterRepository {
  static Future<RegisterModel> registerUser({
    required String name,
    required String phone,
    required String dateOfBirth,
    required String password,
    required String confirmPassword,
  }) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final apiDOB = DateConversionHelper.toYYYYMMDD(dateOfBirth);

    final data = {
      "name": name,
      "phone": phone,
      "date_of_birth": apiDOB,
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
      throw Exception("${res.data["message"]}");
    }
  }
}
