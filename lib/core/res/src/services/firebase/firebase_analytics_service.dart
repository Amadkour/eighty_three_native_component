import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticsService {
  FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver analyticsObserver() =>


      FirebaseAnalyticsObserver(analytics: firebaseAnalytics);


  Future<void> logEvent(String eventName,
      {Map<String, dynamic>? parameters}) async {
    await firebaseAnalytics.logEvent(name: eventName, parameters: parameters);
  }
}
