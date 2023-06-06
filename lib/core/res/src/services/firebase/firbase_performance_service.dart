import 'package:firebase_performance/firebase_performance.dart';

///this calss use to API measure the performance
class FirebasePerformancesService {
  late Trace _trace;

  FirebasePerformancesService() {
    _trace = FirebasePerformance.instance.newTrace("new_trace");
  }

  ///start the performance trace
  Future<void> startTrace({String newTraceName = ""}) async {
    _trace = newTraceName.isEmpty
        ? FirebasePerformance.instance.newTrace("new_trace")
        : FirebasePerformance.instance.newTrace(newTraceName);
    await _trace.start();
    await _trace.stop();
  }

  ///stop the performance trace
  Future<void> stopTrace() async {
    await _trace.stop();
  }
}
