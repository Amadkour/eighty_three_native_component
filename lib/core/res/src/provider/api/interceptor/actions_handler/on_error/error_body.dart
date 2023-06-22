import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eighty_three_native_component/core/res/src/configuration/top_level_configuration.dart';
import 'package:eighty_three_native_component/core/res/src/cubit/global_cubit.dart';
import 'package:eighty_three_native_component/core/res/src/provider/api/interceptor/helper/handle_dialog_error.dart';
import 'package:eighty_three_native_component/core/res/src/provider/api/interceptor/helper/on_resume_network_error.dart';
import 'package:eighty_three_native_component/core/res/src/provider/api/interceptor/helper/otp_scenario.dart';
import 'package:eighty_three_native_component/core/res/src/provider/api/interceptor/helper/reset_password_scenario.dart';
import 'package:eighty_three_native_component/core/res/src/provider/api/status_codes.dart';
import 'package:eighty_three_native_component/core/res/src/services/dependency_jnjection.dart';
import 'package:eighty_three_native_component/core/res/src/services/navigation.dart';
import 'package:eighty_three_native_component/core/res/src/widget/message.dart';

Future<void> errorBody({
  required DioException err,
  required DioExceptionType errorType,
  required ErrorInterceptorHandler handler,
  required List<Future<void> Function()> repeating,
  required dynamic Function(bool) setNetworkError,
  required bool networkError,
  required Future<Response<dynamic>> Function(RequestOptions) onFetch,
  required Future<String?> Function(String) readSecureKey,
  required Future<void> Function() onRemoveSession,
}) async {
  /// ------------------------------------- exceed number of hits -------------------------------------------------------------------- ///

  if (err.response?.statusCode == exceedsRequestsCode) {
    return _exceedNumberHits(err: err, handler: handler);
  }

  /// ----------------------------------------------------------------------------------------------------------------------------------- ///

  /// ------------------------------------- Expired OTP -------------------------------------------------------------------- ///
  // todo: must be test in RESPay and merchant [changed from 1022 to 1062]
  // if the inner code is 1062 => unverifiedAccount or 1076 => expireOTP
  if ([unverifiedAccountOnErrorCode, expireOtpCode]
      .contains(err.response?.data['code'])) {
    _verifyExpiredOTP(
        err: err,
        handler: handler,
        onFetch: onFetch,
        readSecureKey: readSecureKey);
  }

  /// ----------------------------------------------------------------------------------------------------------------------------------- ///

  /// ------------------------------------- Expired Password -------------------------------------------------------------------- ///
  if (err.response?.data['code'] == expiredPasswordCode) {
    resetPasswordScenario();
  }

  /// ----------------------------------------------------------------------------------------------------------------------------------- ///

  /// ------------------------------------- bad Response -------------------------------------------------------------------- ///
  if (<DioExceptionType>[DioExceptionType.badResponse].contains(errorType)) {
    await handleDialogError(
        err, handler, onFetch, readSecureKey, onRemoveSession);
    handler.resolve(err.response!);
  }

  /// ----------------------------------------------------------------------------------------------------------------------------------- ///

  /// ------------------------------------- unknown -------------------------------------------------------------------- ///
  else if (<DioExceptionType>[DioExceptionType.unknown].contains(errorType)) {
    throw SocketException(err.error.toString());
  }

  /// ----------------------------------------------------------------------------------------------------------------------------------- ///

  /// ------------------------------------- timeout -------------------------------------------------------------------- ///
  else {
    _timeOut(errorType, handler, err, repeating, setNetworkError, networkError,
        onFetch);
  }

  /// ----------------------------------------------------------------------------------------------------------------------------------- ///
}

void _verifyExpiredOTP({
  required DioException err,
  required ErrorInterceptorHandler handler,
  required Future<Response<dynamic>> Function(RequestOptions) onFetch,
  required Future<String?> Function(String) readSecureKey,
}) {
  /// Go to OTP Scenario (if your current screen is not verificationMethodPath )
  if (CustomNavigator.instance.currentScreenName != verificationMethodPath) {
    otpScenario(err.response!, onFetch, readSecureKey, errorHandler: handler);
  } else {
    Map<String, dynamic> errros = err.response!.data["errors"];
    if (!(errros).containsKey("error")) {
      CustomNavigator.instance.beforePop?.call();
      CustomNavigator.instance.pop();
    }
    MyToast(errros.toString());
  }
  sl<GlobalCubit>().onLoaded();
  return;
}

void _timeOut(
  DioExceptionType errorType,
  ErrorInterceptorHandler handler,
  DioException err,
  List<Future<void> Function()> repeating,
  Function(bool) setNetworkError,
  bool networkError,
  Future<Response<dynamic>> Function(RequestOptions) onFetch,
) {
  MyToast('timeout$errorType');
  onResumeNetworkError(
      handler, err, repeating, setNetworkError, networkError, onFetch);
}

Future<void> _exceedNumberHits({
  required DioException err,
  required ErrorInterceptorHandler handler,
}) async {
  MyToast((err.response?.data['errors'] as Map<String, dynamic>)
      .values
      .first
      .toString());
  handler.resolve(err.response!);
  return;
}
