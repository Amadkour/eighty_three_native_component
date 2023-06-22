import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:eighty_three_native_component/core/res/src/configuration/top_level_configuration.dart';
import 'package:eighty_three_native_component/core/res/src/provider/api/interceptor/helper/otp_scenario.dart';
import 'package:eighty_three_native_component/core/res/src/provider/api/status_codes.dart';
import 'package:eighty_three_native_component/core/res/src/services/navigation.dart';
import 'package:eighty_three_native_component/core/res/src/widget/dialogs/api_error_dialogs.dart';
import 'package:eighty_three_native_component/core/res/src/widget/message.dart';

Future<void> handleDialogError(
    DioException error,
    ErrorInterceptorHandler handler,
    Future<Response<dynamic>> Function(RequestOptions) onFetch,
    Future<String?> Function(String) readSecureKey,
    Future<void> Function() onRemoveSession) async {
  try {
    final Response<dynamic>? response = error.response;
    final Map<String, dynamic>? data = response?.data as Map<String, dynamic>?;
    final int outerCode = error.response!.statusCode!;
    log(outerCode.toString());
    log(error.response.toString());
    final int? innerCode = data?['code'] as int?;

    /// ---------------------------------------- if the user unauthorized ------------------------------- ///
    if (outerCode == unauthorizedUserOuterCode) {
      _switchInnerCode(innerCode, response, error, handler, onFetch,
          readSecureKey, onRemoveSession);

      /// ------------------------------------------------------------------------------------------------ ///
    } else if ([exceedsRequestsCode, loginFromAnotherAppCode]
        .contains(outerCode)) {
      unauthorizedDialog(error, onRemoveSession: onRemoveSession);
    }

    /// ---------------------------------------- Navigate to the previous screen ------------------------- ///
    else {
      _navigateToPreviousScreenIfExist(error);
    }
  } catch (e) {
    rethrow;
  }
}

_switchInnerCode(
    int? innerCode,
    Response<dynamic>? response,
    DioException error,
    ErrorInterceptorHandler handler,
    Future<Response<dynamic>> Function(RequestOptions) onFetch,
    Future<String?> Function(String) readSecureKey,
    Future<void> Function() onRemoveSession) {
  switch (innerCode) {
    case unverifiedAccountOnErrorCode:
      otpScenario(response!, onFetch, readSecureKey, errorHandler: handler);
      break;
    case unauthorizedUserInnerCode2:
    case unauthorizedUserInnerCode:
      if (error.response?.realUri.toString().contains('login') == false) {
        unauthorizedDialog(error, onRemoveSession: onRemoveSession);
      }
      break;
    case noEnoughMoneyCode:
      MyToast("don't have enough balanced");
      break;
    case imageExceededAllowedSizeCode:
      MyToast('image exceeded the allowed size');
      break;
  }
}

void _navigateToPreviousScreenIfExist(
  DioException error,
) {
  if (CustomNavigator.instance.currentScreenName == verificationMethodPath) {
    CustomNavigator.instance.beforePop?.call();
    CustomNavigator.instance.pop();
  }
  MyToast(error.response?.data['errors'].toString() ?? "invalid data");
}
