import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../errors/failures.dart';

abstract class CurrencyBaseApi {
  Future<Either<Failure, Response<Map<String, dynamic>>>> getCountries();
  Future<Either<Failure, Response<Map<String, dynamic>>>> getCurrencies();
}
