import 'package:get_it/get_it.dart';
import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'dio_service.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  serviceLocator.registerLazySingleton<DioService>(
    () => DioService(baseUrl: "https://vcard.vaccinehomebd.com/api/"),
  );

  serviceLocator.registerLazySingleton<ApiEndpoints>(() => ApiEndpoints());
}
