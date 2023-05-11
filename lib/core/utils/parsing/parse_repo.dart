import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eighty_three_native_component/core/res/src/errors/failures.dart';
import 'package:eighty_three_native_component/core/utils/parsing/parent_model.dart';

class ParentRepo<T extends ParentModel> {
  final Either<Failure, Response<Map<String, dynamic>>> response;
  late ParentModel modelInstance;
  late String? innerMapName;

  ParentRepo(this.response, this.modelInstance, {this.innerMapName});

  Either<Failure, ParentModel> getRepoResponseAsFailureAndModel() {
    return response.fold((Failure l) => Left<Failure, ParentModel>(l),
        (Response<Map<String, dynamic>> successResponse) {
      if (!<int>[200, 201].contains(successResponse.statusCode) ||
          !(successResponse.data!['success'] as bool)) {
        if (successResponse.statusCode == 404 &&
            successResponse.data!['success'] as bool) {
          return Right<Failure, ParentModel>(modelInstance.fromJsonInstance(
              innerMapName == null
                  ? successResponse.data!['data'] as Map<String, dynamic>
                  : ((successResponse.data!['data']
                          as Map<String, dynamic>)[innerMapName]
                      as Map<String, dynamic>)));
        } else {
          return Left<Failure, ParentModel>(ApiFailure(
              code: successResponse.statusCode,
              hint: (successResponse.data!['hint'] ??
                  successResponse.data!['errors'].toString()) as String,
              resourceName: 'banks_repository_line_40',
              errors: (successResponse.data!["errors"] ?? <dynamic>{})
                  as Map<String, dynamic>));
        }
      } else {
        if ((successResponse.data!['data'] as Map<String, dynamic>)
            .containsKey('confirmation_code')) {
          final String otp = (successResponse.data!['data']!
              as Map<String, dynamic>)['confirmation_code'] as String;
          return Left<Failure, ParentModel>(GeneralFailure(message: otp));
        } else {
          modelInstance = modelInstance.fromJsonInstance(innerMapName == null
              ? successResponse.data!['data'] as Map<String, dynamic>
              : ((successResponse.data!['data']
                      as Map<String, dynamic>)[innerMapName]
                  as Map<String, dynamic>));
          return Right<Failure, ParentModel>(modelInstance.fromJsonInstance(
              innerMapName == null
                  ? successResponse.data!['data'] as Map<String, dynamic>
                  : ((successResponse.data!['data']
                          as Map<String, dynamic>)[innerMapName]
                      as Map<String, dynamic>)));
        }
      }
    });
  }

  Either<Failure, List<ParentModel>> getRepoResponseAsFailureAndModelList() {
    // return response.fold((Failure l) => left(l),
    //     (Response<Map<String, dynamic>> successResponse) {
    //   if (!<int>[200, 201].contains(successResponse.statusCode) ||
    //       !(successResponse.data!['success'] as bool)) {

    //     if (successResponse.statusCode == 404 &&
    //         successResponse.data!['success'] as bool) {
    //       final modelList = (successResponse.data!['data'] as List).map((e) {
    //         return modelInstance.fromJsonInstance(e);
    //       }).toList();
    //       return right(modelList);
    //       // return right(modelInstance.fromJsonInstance(innerMapName == null
    //       //     ? successResponse.data!['data'] as Map<String, dynamic>
    //       //     : ((successResponse.data!['data']
    //       //             as Map<String, dynamic>)[innerMapName]
    //       //         as Map<String, dynamic>)));
    //     } else {
    //       return left(ApiFailure(
    //           code: successResponse.statusCode,
    //           hint: (successResponse.data!['hint'] ??
    //               successResponse.data!['errors'].toString()) as String,
    //           resourceName: 'banks_repository_line_40',
    //           errors: (successResponse.data!["errors"] ?? <dynamic>{})
    //               as Map<String, dynamic>));
    //     }
    //   } else {
    //     if ((successResponse.data!['data'] as Map<String, dynamic>)
    //         .containsKey('confirmation_code')) {
    //       final String otp = (successResponse.data!['data']!
    //           as Map<String, dynamic>)['confirmation_code'] as String;
    //       return left(GeneralFailure(message: otp));
    //     } else {
    //       modelInstance = modelInstance.fromJsonInstance(innerMapName == null
    //           ? successResponse.data!['data'] as Map<String, dynamic>
    //           : ((successResponse.data!['data']
    //                   as Map<String, dynamic>)[innerMapName]
    //               as Map<String, dynamic>));
    //       return right(modelInstance.fromJsonInstance(innerMapName == null
    //           ? successResponse.data!['data'] as Map<String, dynamic>
    //           : ((successResponse.data!['data']
    //                   as Map<String, dynamic>)[innerMapName]
    //               as Map<String, dynamic>)));
    //     }
    //   }
    // });

    return response.fold((l) {
      return left(l);
    }, (response) {
      /// success case
      if ([200, 201].contains(response.statusCode) &&
          response.data!['success'] as bool) {
        final modelList = (response.data!['data'] as List).map((e) {
          return modelInstance.fromJsonInstance(e);
        }).toList();

        return right(modelList);
      }

      /// Failure case
      else {
        return left(
          ApiFailure(
            code: response.statusCode,
            hint: (response.data!['hint'] ??
                response.data!['errors'].toString()) as String,
            errors: (response.data!["errors"] ?? <dynamic>{})
                as Map<String, dynamic>,
          ),
        );
      }
    });
  }
}
