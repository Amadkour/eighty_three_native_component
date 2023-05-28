import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticsService {
  FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver analyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: firebaseAnalytics);

}
