import 'package:eighty_three_native_component/core/res/src/services/firebase/Firebase_notification_service.dart';
import 'package:eighty_three_native_component/core/res/src/services/firebase/firebase_crashlytics_service.dart';

class InitFirebase {
  final FirebaseCrashlyticsService _firebaseCrashlyticsService;
  final FirebaseNotificationService _firebaseNotificationService;
  InitFirebase(
      this._firebaseCrashlyticsService, this._firebaseNotificationService);
  Future<void> init() async {
    // crashlytics
    await _firebaseCrashlyticsService.init();
    // notifications
    await _firebaseNotificationService.initNotificationService();
  }
}
