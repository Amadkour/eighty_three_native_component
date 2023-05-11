import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  final FirebaseAnalytics _instance = FirebaseAnalytics.instance;

  Future<void> logEvent(String eventName, Map<String, dynamic> data) async {
    await _instance.setAnalyticsCollectionEnabled(true);
    await _instance.logEvent(
      name: eventName,
      parameters: data,
    );
  }
}
