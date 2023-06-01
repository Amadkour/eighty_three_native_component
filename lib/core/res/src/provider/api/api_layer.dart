import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eighty_three_native_component/core/res/src/errors/failures.dart';

class APILayer {
  // Future<Option<Failure>> apiOptions({
  //   FormData? formData,
  //   required String path,
  //   bool isPost = true,
  // }) async {
  //   try {
  //     final Response<Map<String, dynamic>> res = isPost
  //         ? await _dio.post(
  //             path,
  //             data: formData,
  //           )
  //         : await _dio.get(
  //             path,
  //           );

  //     final Map<String, dynamic>? body = res.data;

  //     if (body?['success'] == true) {
  //       return none();
  //     } else {
  //       return some(ApiFailure(
  //         errors: body?['errors'] as Map<String, dynamic>,
  //       ));
  //     }
  //   } on SocketException {
  //     return some(
  //       NetworkFailure(),
  //     );
  //   } on DioError catch (e) {
  //     return some(ApiFailure(
  //       errors: <String, String>{'': e.message},
  //     ));
  //   }
  // }

  // Future<Either<Failure, Map<String, dynamic>>> apiEither({
  //   FormData? formData,
  //   required String path,
  //   bool isPost = true,
  // }) async {
  //   try {
  //     final Response<Map<String, dynamic>> response =
  //         isPost ? await _dio.post(path, data: formData) : await _dio.get(path);

  //     final Map<String, dynamic>? body = response.data;

  //     if (body?['success'] == true) {
  //       return right(body!);
  //     } else {
  //       return left(ApiFailure(
  //         errors: body?['errors'] as Map<String, dynamic>,
  //       ));
  //     }
  //   } on SocketException {
  //     return left(
  //       NetworkFailure(),
  //     );
  //   } on DioError catch (e) {
  //     return left(ApiFailure(
  //       errors: <String, String>{'': e.message},
  //     ));
  //   }
  // }

  Future<Option<Failure>> apiOption(
    Future<Response<Map<String, dynamic>>> Function() request,
  ) async {
    try {
      final Response<Map<String, dynamic>> res = await request();

      final Map<String, dynamic>? body = res.data;

      if (body?['success'] == true) {
        return none();
      } else {
        return some(ApiFailure(
          errors: body?['errors'] as Map<String, dynamic>,
        ));
      }
    } on SocketException {
      return some(
        NetworkFailure(),
      );
    } on DioError catch (e) {
      return some(ApiFailure(
        errors: <String, String>{'': e.message??""},
      ));
    }
  }

  Future<Either<Failure, Response<Map<String, dynamic>>>> apiEither(
    Future<Response<Map<String, dynamic>>> Function() request,
  ) async {
    try {
      final Response<Map<String, dynamic>> response = await request();

      final Map<String, dynamic>? body = response.data;

      if (body?['success'] == true) {
        return right(response);
      } else {
        return left(
          ApiFailure(
            hint:  (body?['hint']??'') as String,
            errors: body?['errors'] as Map<String, dynamic>?,
          ),
        );
      }
    } on SocketException {
      return left(
        NetworkFailure(),
      );
    } on DioError catch (e) {
      return left(ApiFailure(
        errors: <String, String>{'': e.message??""},
      ));
    }
  }
}
