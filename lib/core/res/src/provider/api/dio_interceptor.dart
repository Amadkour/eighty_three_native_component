// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:eighty_three_native_component/core/res/src/configuration/top_level_configuration.dart';
import 'package:eighty_three_native_component/core/res/src/permissions/permission.dart';
import 'package:eighty_three_native_component/core/res/src/routes/routes_name.dart';

import 'package:eighty_three_native_component/core/res/src/services/navigation.dart';
import 'package:eighty_three_native_component/core/res/src/widget/dialogs/api_error_dialogs.dart';
import 'package:eighty_three_native_component/core/res/src/widget/message.dart';
import 'package:eighty_three_native_component/core/res/src/widget/network_error_widget.dart';

class DioInterceptor extends Interceptor {
  List<Future<void> Function()> repeating = <Future<void> Function()>[];
  Future<void> Function(String key, String data) writeSecureKey;
  Future<String?> Function(String key) readSecureKey;
  Future<void> Function() onRemoveSession;
  Future<Response> Function(RequestOptions options) onFetch;
  Function(bool) setNetworkError;
  String userRole;
  bool networkError;

  DioInterceptor({
    required this.writeSecureKey,
    required this.readSecureKey,
    required this.onRemoveSession,
    required this.onFetch,
    required this.networkError,
    required this.setNetworkError,
    required this.userRole,
  });

  @override
  Future<dynamic> onError(DioError err, ErrorInterceptorHandler handler) async {
    final DioErrorType errorType = err.type;
    log('on Error');
    log(err.type.name);
    log(err.response.toString());
    log(err.response?.data.toString() ?? '');
    try {
      if (<DioErrorType>[DioErrorType.badResponse].contains(errorType)) {
        await _handleDialogError(err, handler);
        handler.resolve(err.response!);
        // handler.next(err);
      } else if (err.response?.statusCode==429) {
        show404Dialog(title: "please, try again after one hour");
      }
      else if (<DioErrorType>[DioErrorType.unknown].contains(errorType)) {
        throw SocketException(err.error.toString());
      }else {
        ///timeout
        MyToast('timeout$errorType');
        onResumeNetworkError(handler, err);
      }
    } on SocketException catch (e) {
      MyToast(e.message);
      log(e.message);
      onResumeNetworkError(handler, err);
    } catch (e) {
      MyToast(e.toString());
      rethrow;
    }
    // super.onError(err, handler);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    log('on response');
    log(response.data.toString());
    final Map<String, dynamic> data = response.data as Map<String, dynamic>;
    log(data.toString());
    if (data['code'] == 1022 &&
        (data['data'] as Map<String, dynamic>)['message'] ==
            "User Account Not Verified, verify your account first!") {
      MyToast(
          ((data['data'] as Map<String, dynamic>)['otp'] as int).toString());
      writeSecureKey("verify_account_pin_code",
          ((data['data'] as Map<String, dynamic>)['otp'] as int).toString());
      unverifiedOnResponse(response.requestOptions, handler);
    } else if (data['data'] is Map<String, dynamic> &&
        (data['data'] as Map<String, dynamic>)
            .containsKey('confirmation_code')) {
      final String otp =
          (data['data'] as Map<String, dynamic>)['confirmation_code'] as String;

      /// used in testing only and removed when get production
      writeSecureKey("verify_confirmation_code", otp);
      MyToast(otp);

      CustomNavigator.instance.pushNamed(
        verificationMethodPath,
        arguments: (String? confirmationCode) async {
          await _repeatOnResponse(
            handler,
            response.requestOptions.copyWith(
              data: (response.requestOptions.data as FormData)
                ..fields.add(
                  MapEntry<String, String>(
                      'confirmation_code', confirmationCode ?? ""),
                ),
            ),
          );
        },
      );

      return;
    }
    super.onResponse(response, handler);
  }

  @override
  Future<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers = <String, String>{
      'Accept': 'application/json',
      'Accept-Language': currentUserPermission.locale ?? 'en',
      "Authorization": currentUserPermission.token ?? "",
      "X-USER-ROLE": "merchant"
    };

    log('onRequest ${options.path} =>  token => ${currentUserPermission.token}');
    if (options.method == 'GET') {
      options.queryParameters.addAll(<String, dynamic>{"user_uuid": currentUserPermission.userId});
    }
    //TODO should remove in production
    if (options.method.toUpperCase() == "POST" &&
        currentUserPermission.userId != null &&
        options.data is Map<String, dynamic>) {
      (options.data as Map<String, dynamic>)['user_uuid'] =
          currentUserPermission.userId;
    }
    if (options.method.toUpperCase() == "POST" &&
        currentUserPermission.userId != null &&
        options.data is FormData) {
      final FormData map = options.data as FormData;
      map.fields.add(MapEntry<String, String>(
          "user_uuid", currentUserPermission.userId ?? ''));

      options.data = map;
    }

    return handler.next(options);
  }

  Future<void> unverifiedOnResponse(
      RequestOptions requestOptions, ResponseInterceptorHandler handler) async {
    final String? alreadyOpened = await isOtpScreenAlreadyOpened();
    if (alreadyOpened == "false") {
      CustomNavigator.instance.pushNamed(RoutesName.otp,
          arguments: (String? code) async {
        CustomNavigator.instance.pop();

        /// repeat last request with fresh token

        await _repeatOnResponse(handler, requestOptions);
      });
    }
  }

  ///login,forget
  Future<void> unverifiedOnError(
      RequestOptions requestOptions, ErrorInterceptorHandler handler) async {
    final String? alreadyOpened = await isOtpScreenAlreadyOpened();
    if (alreadyOpened == "false") {
      CustomNavigator.instance.pushNamed(RoutesName.otp,
          arguments: (String? value) async {
        CustomNavigator.instance.pop();

        /// repeat last request with fresh token
        await _repeatOnError(handler, requestOptions);
      });
    }
  }

  Future<void> _handleDialogError(
      DioError error, ErrorInterceptorHandler handler) async {
    try {
      final Response<dynamic>? response = error.response;
      final Map<String, dynamic>? data =
          response?.data as Map<String, dynamic>?;
      final int outerCode = error.response!.statusCode!;
      log(outerCode.toString());
      log(error.response.toString());
      final int? innerCode = data?['code'] as int?;
      if (outerCode == 400) {
        switch (innerCode) {
          case 1062:
            unverifiedOnError(error.requestOptions, handler);
            break;
          case 1061:
          case 1082:
            if (error.response?.realUri.toString().contains('login') == false) {
              unauthorizedDialog(error, onRemoveSession: onRemoveSession);
            }
            break;
          case 1065:
            MyToast("don't have enough balanced");
            break;
          case 1442:
            MyToast('image exceeded the allowed size');
            break;
          // default:
          // if ((error.response?.data['errors'] as Map).containsKey('wallet_uuid')) {
          //   final RequestOptions requestOptions =
          //   (error.requestOptions..data.fields.add(const MapEntry('wallet_uuid', 'wallet_uuid')));
          //   _repeatOnError(handler, requestOptions);
          // }
        }
      }
      /// 401 : login from another app
      /// 429 : request limit
      else if ([429,401].contains(outerCode)) {
        unauthorizedDialog(error, onRemoveSession: onRemoveSession);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _repeatOnError(
      ErrorInterceptorHandler handler, RequestOptions options) async {
    if (options.data is FormData) {
      options.data = createNewFormData(options.data as FormData);
    }
    try {
      onFetch(options).then(
        (Response<dynamic> response) {
          handler.resolve(response);
        },
        onError: (Object error) {
          handler.reject(_dioError(error, options));
        },
      );
    } catch (_) {}
  }

  Future<void> _repeatOnResponse(
      ResponseInterceptorHandler handler, RequestOptions options) async {
    if (options.data is FormData) {
      options.data = createNewFormData(options.data as FormData);
    }
    try {
      await onFetch(options).then(
        (Response<dynamic> response) => handler.resolve(response),
        onError: (Object error) {
          handler.reject(_dioError(error, options));
        },
      );
    } catch (_) {}
  }

  DioError _dioError(Object error, RequestOptions options) {
    return error is DioError ? error : DioMixin.assureDioError(error, options);
  }

  Future<void> onResumeNetworkError(
      ErrorInterceptorHandler handler, DioError err) async {
    ///add api to queue
    repeating.add(() async {
      await _repeatOnError(handler, err.requestOptions);
    });
    log(err.requestOptions.path);
    log(err.requestOptions.data.toString());

    ///connection error
    if (!networkError) {
      setNetworkError(true);
      try {
        CustomNavigator.instance.push(
          routeWidget: NetworkErrorPage(
            callback: () async {
              ///repeat all queue
              for (var element in repeating) {
                await element.call();
              }
              ///clear
              repeating.clear();
            },
          ),
        );
      } catch (e) {
        MyToast(e.toString());
      }
    }
  }

  FormData createNewFormData(FormData data) {
    final FormData formData = FormData();
    formData.fields.addAll(data.fields);
    //formData.files.addAll(data.files);
    return formData;
  }

  Future<String?> isOtpScreenAlreadyOpened() => readSecureKey("already_opened");
}
