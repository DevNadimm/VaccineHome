import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/services/app_preferences.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/notification_service.dart';
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

      // Update app preferences if available
      if (model.accessToken != null) await AppPreferences.setAccessToken(model.accessToken ?? '');
      if (model.data?.id != null) await AppPreferences.setUserId(model.data!.id ?? 0);
      if (model.data?.avatar != null) await AppPreferences.setUserAvatar(model.data!.avatar!);
      if (model.data?.name != null) await AppPreferences.setUserName(model.data!.name!);
      if (model.data?.email != null) await AppPreferences.setUserEmail(model.data!.email!);
      if (model.data?.phone != null) await AppPreferences.setUserPhone(model.data!.phone!);
      if (model.data?.dateOfBirth != null) await AppPreferences.setUserDOB(model.data!.dateOfBirth!);
      if (model.data?.gender != null) await AppPreferences.setUserGender(model.data!.gender!);
      if (model.data?.address != null) await AppPreferences.setUserAddress(model.data!.address!);

      await NotificationService.instance.initialize();

      return model;
    } else {
      throw Exception(Messages.loginFailed);
    }
  }
}
