import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/services/app_preferences.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';
import 'package:vaccine_home/features/auth/data/models/login_model.dart';

class LoginRepository {
  static Future<LoginModel> loginUser({
    required String email,
    required String password,
  }) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final data = {
      "email": email,
      "password": password,
    };

    final res = await dioService.postRequest(
      apiEndpoints.loginUser,
      data: data,
      errorMessage: Messages.loginFailed,
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      final model = LoginModel.fromJson(res.data);

      dioService.setAuthToken(model.accessToken ?? '');

      // Set app preferences after login
      await AppPreferences.setAccessToken(model.accessToken ?? '');
      await AppPreferences.setUserName(model.data?.name ?? '');
      await AppPreferences.setUserEmail(model.data?.email ?? '');
      await AppPreferences.setUserPhone(model.data?.phone ?? '');
      await AppPreferences.setUserAvatar(model.data?.avatar ?? '');

      return model;
    } else {
      throw Exception(Messages.loginFailed);
    }
  }
}
