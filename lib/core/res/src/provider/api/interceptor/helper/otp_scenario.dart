import 'package:dio/dio.dart';
import 'package:eighty_three_native_component/core/res/src/configuration/top_level_configuration.dart';
import 'package:eighty_three_native_component/core/res/src/provider/api/interceptor/helper/is_otp_screen_already_opened.dart';
import 'package:eighty_three_native_component/core/res/src/provider/api/interceptor/helper/repeat_on_response.dart';
import 'package:eighty_three_native_component/core/res/src/provider/api/interceptor/helper/reposear_on_error.dart';
import 'package:eighty_three_native_component/core/res/src/services/navigation.dart';

Future<void> otpScenario(
    Response response,
    Future<Response<dynamic>> Function(RequestOptions) onFetch,
    Future<String?> Function(String key) readSecureKey,
    {ResponseInterceptorHandler? responseHandler,
    ErrorInterceptorHandler? errorHandler}) async {
  final String? alreadyOpened = await isOtpScreenAlreadyOpened(readSecureKey);
  if (alreadyOpened == "false" ||
      alreadyOpened == null ||
      alreadyOpened == "") {
    CustomNavigator.instance.pushNamed(
      verificationMethodPath,
      arguments: (String? confirmationCode) async {
        if (errorHandler == null) {
          await repeatOnResponse(
              responseHandler!,
              response.requestOptions.copyWith(
                data: (response.requestOptions.data as FormData)
                  ..fields.removeWhere(
                      (element) => element.key == "confirmation_code")
                  ..fields.add(
                    MapEntry<String, String>(
                        'confirmation_code', confirmationCode ?? ""),
                  ),
              ),
              onFetch);
        } else {
          await repeatOnError(
              errorHandler,
              response.requestOptions.copyWith(
                data: (response.requestOptions.data as FormData)
                  ..fields.removeWhere(
                      (element) => element.key == "confirmation_code")
                  ..fields.add(
                    MapEntry<String, String>(
                        'confirmation_code', confirmationCode ?? ""),
                  ),
              ),
              onFetch);
        }
      },
    );
  }
}
