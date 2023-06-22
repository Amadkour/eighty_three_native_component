library eighty_three_component;

import 'package:dio/dio.dart';
import 'package:eighty_three_native_component/core/res/src/configuration/top_level_configuration.dart';
import 'package:eighty_three_native_component/core/res/src/provider/api/interceptor/dio_interceptor.dart';
import 'package:eighty_three_native_component/core/res/src/services/dependency_jnjection.dart';
import 'package:eighty_three_native_component/core/res/src/services/local_storage_service.dart';
import 'package:eighty_three_native_component/core/utils/certificate_handle.dart';
import 'package:http/http.dart';

enum BaseUrlModules {
  ecommerce,
  authentication,
  finance,
  wallet;

  String get name => urlFromEnum(this);
}

/// remove when new server is done
String urlFromEnum(BaseUrlModules? baseUrlModules) {
  if (!userOldServer) {
    return baseUrlModules.toString().split('.').last;
  } else {
    switch (baseUrlModules) {
      case BaseUrlModules.authentication:
        return "/authentication.eightyythree.com/api/authentication";
      case BaseUrlModules.ecommerce:
        return "/res-ecommerce.eightyythree.com/api/ecommerce";
      case BaseUrlModules.finance:
        return "/wallet.eightyythree.com/api/finance";
      case BaseUrlModules.wallet:
        return "/wallet.eightyythree.com/api/wallet";
      default:
        return "/authentication.eightyythree.com/api/authentication";
    }
  }
}

class APIConnection {
  bool showMessage = true;
  bool networkError = false;
  final Dio dio = Dio();

  APIConnection(
      {String userRole = '',
      String? baseUrl,
      Client? client,
      Future<void> Function()? resetCallback}) {
    dio.options.baseUrl =
        baseUrl ?? (userOldServer ? "https:/" : "http://gfi.group/api");
    dio.options.followRedirects = false;
    dio.options.contentType = 'application/json';
    dio.options.connectTimeout = const Duration(seconds: 50);
    dio.options.receiveTimeout = const Duration(seconds: 50);

    dio.options.validateStatus = (int? statusCode) {
      if (statusCode == null) {
        return false;
      }
      if (statusCode == 422) {
        // your http status code
        return false;
      } else {
        return statusCode >= 200 && statusCode < 300;
      }
    };
    dio.interceptors.add(DioInterceptor(
      networkError: networkError,
      onFetch: dio.fetch,
      setNetworkError: (value) => networkError = value,
      onRemoveSession: resetCallback ?? sl<LocalStorageService>().removeSession,
      readSecureKey: sl<LocalStorageService>().readSecureKey,
      writeSecureKey: sl<LocalStorageService>().writeSecureKey,
      userRole: userRole,
    ));
    dio.interceptors.add(LogInterceptor(
      request: false,
      requestHeader: false,
      responseHeader: false,
    ));
    // add ssl certificate
    handleSSL(dio);
  }

// Future<bool> checkConnection() async {
//   bool connectionStatus = true;
//   try {
//     await Connectivity()
//         .checkConnectivity()
//         .then((ConnectivityResult value) async {
//       if (value == ConnectivityResult.mobile ||
//           value == ConnectivityResult.wifi ||
//           value == ConnectivityResult.none) {
//         try {
//           final List<InternetAddress> result =
//               await InternetAddress.lookup('example.com');
//           if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//             connectionStatus = true;
//           } else {
//             connectionStatus = false;
//           }
//         } on SocketException catch (_) {
//           connectionStatus = false;
//           print('socket error1 = ${_.toString()}');
//         }
//       } else {
//         connectionStatus = false;
//       }
//     });
//   } catch (_) {
//     debugPrint('socket error2 = ${_.toString()}');
//     connectionStatus = false;
//   }
//   return connectionStatus;
// }
}
