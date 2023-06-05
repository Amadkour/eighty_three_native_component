import 'package:firebase_performance/firebase_performance.dart';

class FirebasePerformancesService {
  late Trace _trace;

  FirebasePerformancesService() {
    _trace = FirebasePerformance.instance.newTrace("new_trace");
  }

  Future<void> startTrace({String newTraceName = ""}) async {
    _trace = newTraceName.isEmpty
        ? FirebasePerformance.instance.newTrace("new_trace")
        : FirebasePerformance.instance.newTrace(newTraceName);
    await _trace.start();
    await _trace.stop();
  }

  Future<void> stopTrace() async {
    await _trace.stop();
  }
}
