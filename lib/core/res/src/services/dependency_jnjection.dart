import 'package:eighty_three_native_component/core/res/src/cubit/country_type/controller/country_type_cubit.dart';
import 'package:eighty_three_native_component/core/res/src/cubit/currency/provider/api/currency_base_api.dart';
import 'package:eighty_three_native_component/core/res/src/cubit/currency/provider/api/currency_remote_api.dart';
import 'package:eighty_three_native_component/core/res/src/cubit/currency/provider/repo/currency_repo.dart';
import 'package:eighty_three_native_component/core/res/src/cubit/global_cubit.dart';
import 'package:eighty_three_native_component/core/res/src/provider/api/api_connection.dart';

import 'package:eighty_three_native_component/core/res/src/services/analytics_service.dart';
import 'package:eighty_three_native_component/core/res/src/services/firebase/firbase_performance_service.dart';
import 'package:eighty_three_native_component/core/res/src/services/firebase/firebase_analytics_service.dart';
import 'package:eighty_three_native_component/core/res/src/services/firebase/firebase_crashlytics_service.dart';
import 'package:eighty_three_native_component/core/res/src/services/firebase/firebase_notification_service.dart';
import 'package:eighty_three_native_component/core/res/src/services/firebase/init_firebase.dart';
import 'package:eighty_three_native_component/core/res/src/services/image_picker_service.dart';
import 'package:eighty_three_native_component/core/res/src/services/local_storage_service.dart';

import 'package:eighty_three_native_component/core/utils/share_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

final GetIt sl = GetIt.instance;

class CustomDependencyInjection {
  static nativeSetUp(
      {String? apiBaseUrl,
      Future<void> Function()? resetCallback,
      required String packageName,
      required String appName}) async {
    //! packages
    registerSingleton(
      () => const FlutterSecureStorage(),
    );
    registerSingleton(() => ImagePicker());

// firebase
    registerSingleton(() => FlutterLocalNotificationsPlugin());
    registerSingleton(() => FirebaseNotificationsService(sl(), packageName, appName));
    registerSingleton(() => FirebasePerformancesService());
    registerSingleton(() => FirebaseCrashlyticsService());
    registerSingleton(() => FirebaseAnalyticsService());

    //!services
    final localStorageService = await LocalStorageService(sl()).init();
    registerSingleton(() => localStorageService);
    registerSingleton(() => ShareService());
    registerSingleton(() => ImagePickerService(sl()));
    registerSingleton(() => AnalyticsService());

    //! api connections
    registerSingleton(() => APIConnection(baseUrl: apiBaseUrl, resetCallback: resetCallback));

    registerSingleton(() => GlobalCubit());

    //! currency
    registerSingleton<CurrencyBaseApi>(() => CurrencyRemoteApi(sl()));
    registerSingleton(() => CurrencyRepository(sl<CurrencyBaseApi>()));

    //!Country
    registerSingleton(() => CountryTypeCubit());

    ///error screen
    ErrorWidget.builder = (FlutterErrorDetails details) => const SizedBox.shrink();

    /// init firebase services
    await InitFirebase.instance.init();
  }

  static registerFactory<T extends Object>(T Function() factory, {String? instanceName}) {
    sl.registerFactory<T>(factory, instanceName: instanceName);
  }

  static void registerSingleton<T extends Object>(T Function() singleton, {String? instanceName}) {
    sl.registerLazySingleton(singleton, instanceName: instanceName);
  }

  static Future<void> resetSingleton<T extends Object>() async {
    await sl.resetLazySingleton<T>();
  }

  static Future<void> resetAll() async {
    await sl.reset();
  }

  static Future<void> reInitialize({required String packageName, required String appName}) async {
    await sl.reset();
    await nativeSetUp(appName: appName, packageName: packageName);
  }
}
