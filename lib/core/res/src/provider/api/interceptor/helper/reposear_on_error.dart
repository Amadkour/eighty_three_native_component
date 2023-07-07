import 'package:dio/dio.dart';
import 'package:eighty_three_native_component/core/res/src/provider/api/interceptor/helper/create_new_form_data.dart';
import 'package:eighty_three_native_component/core/res/src/provider/api/interceptor/helper/dio_error.dart';

Future<void> repeatOnError(
    ErrorInterceptorHandler handler,
    RequestOptions options,
    Future<Response> Function(RequestOptions options) onFetch) async {
  if (options.data is FormData) {
    options.data = createNewFormData(options.data as FormData);
  }
  try {
    onFetch(options).then(
      (Response<dynamic> response) {
        handler.resolve(response);
      },
      onError: (Object error) {
        handler.reject(dioError(error, options));
      },
    );
  } catch (_) {}
}
