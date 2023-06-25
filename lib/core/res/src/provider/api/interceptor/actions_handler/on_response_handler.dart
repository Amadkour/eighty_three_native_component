import 'package:dio/dio.dart';
import 'package:eighty_three_native_component/core/res/src/configuration/top_level_configuration.dart';
import 'package:eighty_three_native_component/core/res/src/provider/api/interceptor/helper/otp_scenario.dart';
import 'package:eighty_three_native_component/core/res/src/provider/api/interceptor/helper/reset_password_scenario.dart';
import 'package:eighty_three_native_component/core/res/src/provider/api/status_codes.dart';
import 'package:eighty_three_native_component/core/res/src/services/dependency_jnjection.dart';
import 'package:eighty_three_native_component/core/res/src/services/firebase/firbase_performance_service.dart';
import 'package:eighty_three_native_component/core/res/src/services/navigation.dart';
import 'package:eighty_three_native_component/core/res/src/widget/message.dart';

void onResponseHandler(
  Response<dynamic> response,
  Future<Response<dynamic>> Function(RequestOptions) onFetch,
  ResponseInterceptorHandler handler,
  Future<String?> Function(String) readSecureKey, {
  ResponseInterceptorHandler? responseHandler,
  ErrorInterceptorHandler? errorHandler,
}) {
  ///stop performance trace to claculate request time
  sl<FirebasePerformancesService>().stopTrace();

  final Map<String, dynamic> data = response.data as Map<String, dynamic>;

  /// ---------------------- exceed number of hits ------------------------------- ///
  if (response.statusCode == exceedsRequestsCode) {
    _exceedNumberOfHits();
  }

  /// ---------------------------------------------------------------------------- ///

  /// ---------------------- Reset Password ------------------------------- ///
  if (response.data['code'] == expiredPasswordCode) {
    resetPasswordScenario();
  }

  /// ---------------------------------------------------------------------------- ///

  /// ------------------------------------- Expired OTP -------------------------------------------------------------------- ///
  /// :todo must be test in RESPay and merchant [changed from 1022 to 1062]
  /// unverified account and expire otp
  if ([unverifiedAccountOnResponseCode, expireOtpCode].contains(data['code'])) {
    _verifyExpriedOtp(response, onFetch, readSecureKey,
        handler: handler, errorHandler: errorHandler);
  }
}

/// --------------------------------------------------------------------------------------------------------------------- ///

void _exceedNumberOfHits() {
  MyToast("please, try again after one hour or contact us");
  return;
}

void _verifyExpriedOtp(
    Response response,
    Future<Response<dynamic>> Function(RequestOptions) onFetch,
    Future<String?> Function(String key) readSecureKey,
    {ResponseInterceptorHandler? handler,
    ErrorInterceptorHandler? errorHandler}) {
  if (CustomNavigator.instance.currentScreenName != verificationMethodPath) {
    otpScenario(response, onFetch, readSecureKey,
        responseHandler: handler, errorHandler: errorHandler);
  } else {
    MyToast("invalid otp, try again");
  }
  return;
}
