import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class FirebaseCrashlyticsService {
  void init() {
    FlutterError.onError = (FlutterErrorDetails details) {
      // Check if the exception is related to a specific error message (prevent upload keyboard issue)
      if (details
          .exceptionAsString()
          .contains('HardwareKeyboard.handleKeyEvent')) {
        // Skip logging this exception
        return;
      }

      // await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      // Pass all uncaught errors from the framework to Crashlytics.
      // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      PlatformDispatcher.instance.onError =
          (Object exception, StackTrace stackTrace) {
        FirebaseCrashlytics.instance
            .recordError(exception, stackTrace, fatal: true);
        return true;
      };

      // Isolate.current.addErrorListener(RawReceivePort((List<dynamic> pair) async {
      //   final List<dynamic> errorAndStacktrace = pair;
      //   await FirebaseCrashlytics.instance.recordError(
      //     errorAndStacktrace.first,
      //     errorAndStacktrace.last is StackTrace
      //         ? errorAndStacktrace.last as StackTrace
      //         : null,
      //   );
      // }).sendPort);
    };

    void crash() {
      FirebaseCrashlytics.instance.crash();
    }

    Future<void> recordError(String error) async {
      await FirebaseCrashlytics.instance.recordError(error, StackTrace.empty);
    }
  }
}
