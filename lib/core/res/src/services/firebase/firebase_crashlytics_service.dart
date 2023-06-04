import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class FirebaseCrashlyticsService {
  Future<void> init() async {
    // await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    // Pass all uncaught errors from the framework to Crashlytics.
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    // Isolate.current.addErrorListener(RawReceivePort((List<dynamic> pair) async {
    //   final List<dynamic> errorAndStacktrace = pair;
    //   await FirebaseCrashlytics.instance.recordError(
    //     errorAndStacktrace.first,
    //     errorAndStacktrace.last is StackTrace
    //         ? errorAndStacktrace.last as StackTrace
    //         : null,
    //   );
    // }).sendPort);
  }

  void crash() {
    FirebaseCrashlytics.instance.crash();
  }

  Future<void> recordError(String error) async {
    await FirebaseCrashlytics.instance.recordError(error, StackTrace.empty);
  }
}
