import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eighty_three_native_component/core/res/src/provider/api/interceptor/actions_handler/on_error/error_body.dart';
import 'package:eighty_three_native_component/core/res/src/provider/api/interceptor/helper/on_resume_network_error.dart';
import 'package:eighty_three_native_component/core/res/src/services/dependency_jnjection.dart';
import 'package:eighty_three_native_component/core/res/src/services/firebase/firbase_performance_service.dart';
import 'package:eighty_three_native_component/core/res/src/widget/message.dart';

Future<dynamic> onErrorHandler(
  DioException err,
  ErrorInterceptorHandler handler,
  List<Future<void> Function()> repeating,
  dynamic Function(bool) setNetworkError,
  bool networkError,
  Future<Response<dynamic>> Function(RequestOptions) onFetch,
  Future<String?> Function(String) readSecureKey,
  Future<void> Function() onRemoveSession,
) async {
  ///stop performance trace to claculate request time
  sl<FirebasePerformancesService>().stopTrace();

  final DioExceptionType errorType = err.type;
  try {
    await errorBody(
        err: err,
        errorType: errorType,
        handler: handler,
        repeating: repeating,
        setNetworkError: setNetworkError,
        networkError: networkError,
        onFetch: onFetch,
        readSecureKey: readSecureKey,
        onRemoveSession: onRemoveSession);
  } on SocketException catch (e) {
    log(e.message);
    onResumeNetworkError(
        handler, err, repeating, setNetworkError, networkError, onFetch);
  } catch (e) {
    rethrow;
  }
}
