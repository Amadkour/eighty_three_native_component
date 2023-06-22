import 'package:dio/dio.dart';
import 'package:eighty_three_native_component/core/res/src/permissions/permission.dart';

void requestConfiguration(RequestOptions options) {
  if (options.method == 'GET') {
    options.queryParameters
        .addAll(<String, dynamic>{"user_uuid": currentUserPermission.userId});
  }
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

  /// for merchant only
  options.headers = options.headers..addAll({"X-USER-ROLE": "merchant"});
}
