import 'package:engg/repositories/pharmacy.dart';
import 'package:get_it/get_it.dart';

import 'app_config.dart';

Future<void> getItSetUp({bool testing = false}) async {
  final getIt = GetIt.instance;

  if (testing) {
    // can setup mocks here
  }

  getIt.registerSingletonAsync<AppConfig>(() async {
    AppConfig appConfig = AppConfig();
    await appConfig.setup();
    return appConfig;
  });

  getIt.registerLazySingleton<PharmacyRepository>(
    () => PharmacyRepository(),
  );

  return getIt.allReady();
}
