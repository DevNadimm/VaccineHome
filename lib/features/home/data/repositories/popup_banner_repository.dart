import 'package:dio/dio.dart';
import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';
import 'package:vaccine_home/features/home/data/models/popup_banner_model.dart';

class PopupBannerRepository {
  static Future<PopupBannerData?> fetchPopupBanner() async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final Response res = await dioService.getRequest(
      apiEndpoints.checkBanner,
      errorMessage: Messages.popupBannerFetchFailed,
    );

    if (res.statusCode == 200) {
      final model = PopupBannerModel.fromJson(res.data);
      return model.data;
    } else {
      throw Exception(Messages.popupBannerFetchFailed);
    }
  }

  static Future<bool> markPopupAsRead(String id) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final data = {
      "banner_id": id
    };

    final Response res = await dioService.postRequest(
      apiEndpoints.readBanner,
      data: data,
      errorMessage: Messages.popupBannerMarkAsReadFailed,
    );

    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception(Messages.popupBannerMarkAsReadFailed);
    }
  }
}
