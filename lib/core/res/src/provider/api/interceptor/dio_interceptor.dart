// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

import 'package:eighty_three_native_component/core/res/src/provider/api/interceptor/actions_handler/on_error/on_error_handler.dart';
import 'package:eighty_three_native_component/core/res/src/provider/api/interceptor/actions_handler/on_request_handler.dart';
import 'package:eighty_three_native_component/core/res/src/provider/api/interceptor/actions_handler/on_response_handler.dart';

class DioInterceptor extends Interceptor {
  List<Future<void> Function()> repeating = <Future<void> Function()>[];
  Future<void> Function(String key, String data) writeSecureKey;
  Future<String?> Function(String key) readSecureKey;
  Future<void> Function() onRemoveSession;
  Future<Response> Function(RequestOptions options) onFetch;
  Function(bool) setNetworkError;
  String userRole;
  bool networkError;

  DioInterceptor(
      {required this.writeSecureKey,
      required this.readSecureKey,
      required this.onRemoveSession,
      required this.onFetch,
      required this.networkError,
      required this.setNetworkError,
      required this.userRole});

  @override
  Future<dynamic> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    return await onErrorHandler(err, handler, repeating, setNetworkError,
        networkError, onFetch, readSecureKey, onRemoveSession);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    onResponseHandler(response, onFetch, handler, readSecureKey, responseHandler: handler,onEnd: (){
      super.onResponse(response, handler);
    });
  }

  @override
  Future<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    return await onRequestHandler(options, handler);
  }
}
