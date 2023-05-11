import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eighty_three_native_component/core/res/src/cubit/country_type/provider/api/country_type_api.dart';
import 'package:eighty_three_native_component/core/res/src/cubit/country_type/provider/model/country_type.dart';
import 'package:eighty_three_native_component/core/res/src/errors/failures.dart';
import 'package:eighty_three_native_component/core/utils/parsing/parent_model.dart';
import 'package:eighty_three_native_component/core/utils/parsing/parse_repo.dart';

class CountryTypeRepository {
  CountryTypeApi countryApi = CountryTypeApi.instance;

  static final CountryTypeRepository _instance =
      CountryTypeRepository._singleTone();

  CountryTypeRepository._singleTone();

  static CountryTypeRepository get instance => _instance;
  Future<Either<Failure, ParentModel>> getCountryType(
      {String? suffixUrl}) async {
    final Either<Failure, Response<Map<String, dynamic>>> response =
        await countryApi.getCountryType(suffixUrl: suffixUrl);
    final ParentRepo<ParentModel> parentRepo =
        ParentRepo<CountryTypeList>(response, CountryTypeList());
    return parentRepo.getRepoResponseAsFailureAndModel();
  }
}
