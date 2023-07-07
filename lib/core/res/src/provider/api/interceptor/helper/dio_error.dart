import 'package:dio/dio.dart';

DioException dioError(Object error, RequestOptions options) {
  return error as DioException;
  //return error is DioError ? error : DioMixin.assureDioError(error, options);
}
