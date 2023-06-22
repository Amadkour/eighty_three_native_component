import 'package:dio/dio.dart';
import 'package:eighty_three_native_component/core/res/src/permissions/permission.dart';
import 'package:eighty_three_native_component/core/res/src/provider/api/interceptor/helper/request_configuration.dart';
import 'package:eighty_three_native_component/core/res/src/services/dependency_jnjection.dart';
import 'package:eighty_three_native_component/core/res/src/services/firebase/firbase_performance_service.dart';

Future<dynamic> onRequestHandler(
    RequestOptions options, RequestInterceptorHandler handler) async {
  ///start performance trace
  sl<FirebasePerformancesService>().startTrace(newTraceName: options.path);
  options.headers = <String, String>{
    'Accept': 'application/json',
    'Accept-Language': currentUserPermission.locale ?? 'en',
    "Authorization": currentUserPermission.token ?? "",
  };

  ///RESPay and merchant config
  ///:todo will remove on respay production
  requestConfiguration(options);

  return handler.next(options);
}
