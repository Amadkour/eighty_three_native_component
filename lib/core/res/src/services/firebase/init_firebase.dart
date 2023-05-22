import 'package:eighty_three_native_component/core/res/src/services/dependency_jnjection.dart';
import 'package:eighty_three_native_component/core/res/src/services/firebase/Firebase_notification_service.dart';
import 'package:eighty_three_native_component/core/res/src/services/firebase/firebase_crashlytics_service.dart';

class InitFirebase {
  InitFirebase._singleTone();
  static final InitFirebase _instance = InitFirebase._singleTone();
  static InitFirebase get instance => _instance;

  Future<void> init() async {
    // crashlytics
    await sl<FirebaseCrashlyticsService>().init();
    // notifications
    await sl<FirebaseNotificationService>().initNotificationService();
  }
}
