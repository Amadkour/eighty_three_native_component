import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:eighty_three_native_component/core/res/src/constant/shared_orefrences_keys.dart';
import 'package:eighty_three_native_component/core/res/src/provider/api/interceptor/helper/reposear_on_error.dart';
import 'package:eighty_three_native_component/core/res/src/services/navigation.dart';
import 'package:eighty_three_native_component/core/res/src/widget/message.dart';
import 'package:eighty_three_native_component/core/res/src/widget/network_error_widget.dart';

Future<void> onResumeNetworkError(
    ErrorInterceptorHandler handler,
    DioException err,
    List<Future<void> Function()> repeating,
    Function(bool) setNetworkError,
    bool networkError,
    Future<Response<dynamic>> Function(RequestOptions) onFetch,
    ) async {
  ///add api to queue
  repeating.add(() async {
    await repeatOnError(handler, err.requestOptions, onFetch);
  });
  log(err.requestOptions.path);
  log(err.requestOptions.data.toString());

  ///connection error
  if (!networkError) {
    setNetworkError(true);
    try {
      if(CustomNavigator.instance.currentScreenName!="/error"){
        CustomNavigator.instance.pushWithoutAnimations(
          name: "/error",
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
      }
    } catch (e) {
      MyToast(e.toString());
    }
  }
}
