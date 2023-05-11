import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eighty_three_native_component/core/res/src/cubit/country_type/provider/end_points.dart';

import 'package:eighty_three_native_component/core/res/src/errors/failures.dart';
import 'package:eighty_three_native_component/core/res/src/provider/api/api_connection.dart';
import 'package:eighty_three_native_component/core/res/src/services/dependency_jnjection.dart';

class CountryTypeApi {
  CountryTypeApi._singleTone();
  static final CountryTypeApi _instance = CountryTypeApi._singleTone();

  static CountryTypeApi get instance => _instance;

  Future<Either<Failure, Response<Map<String, dynamic>>>> getCountryType(
      {String? suffixUrl}) async {
    final Response<Map<String, dynamic>> res =
        await sl<APIConnection>().dio.get(suffixUrl ?? getCountryTypesPath);
    if (res.data!['success'] == false) {
      return left(GeneralFailure(message: res.data!['message'] as String));
    } else {
      return right(res);
    }
  }
}
