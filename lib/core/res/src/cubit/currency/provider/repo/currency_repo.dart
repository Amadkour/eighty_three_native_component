import 'dart:core';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eighty_three_native_component/core/res/src/cubit/country/country_list_model.dart';

import 'package:eighty_three_native_component/core/res/src/cubit/currency/provider/model/currency_list_model.dart';
import 'package:eighty_three_native_component/core/res/src/errors/failures.dart';

import 'package:eighty_three_native_component/core/utils/parsing/parent_model.dart';
import 'package:eighty_three_native_component/core/utils/parsing/parse_repo.dart';
import '../api/currency_base_api.dart';

class CurrencyRepository {
  final CurrencyBaseApi _api;

  CurrencyRepository(this._api);

  Future<Either<Failure, ParentModel>> getCurrencies() async {
    final Either<Failure, Response<Map<String, dynamic>>> json =
        await _api.getCurrencies();
    final ParentRepo<CurrencyListModel> parentRepo =
        ParentRepo<CurrencyListModel>(json, CurrencyListModel());
    return parentRepo.getRepoResponseAsFailureAndModel();
  }

  Future<Either<Failure, ParentModel>> getCountries() async {
    final Either<Failure, Response<Map<String, dynamic>>> json =
        await _api.getCountries();
    final ParentRepo<CountryListModel> parentRepo =
        ParentRepo<CountryListModel>(json, CountryListModel());
    return parentRepo.getRepoResponseAsFailureAndModel();
  }
}
