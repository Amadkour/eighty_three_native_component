import 'package:firebase_performance/firebase_performance.dart';

class FirebasePerformancesService {
  late Trace _trace;

  FirebasePerformancesService() {
    _trace = FirebasePerformance.instance.newTrace("new_trace");
  }

  Future<void> trace(
      {String newTraceName = "",
      required Future<void> Function() callback}) async {
    _trace = newTraceName.isEmpty
        ? FirebasePerformance.instance.newTrace("new_trace")
        : FirebasePerformance.instance.newTrace(newTraceName);
    await _trace.start();
    await callback();
    await _trace.stop();
  }
}
