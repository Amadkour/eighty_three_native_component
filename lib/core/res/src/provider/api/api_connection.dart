library eighty_three_component;

import 'dart:convert';import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:eighty_three_native_component/core/res/src/configuration/top_level_configuration.dart';
import 'package:eighty_three_native_component/core/res/src/provider/api/interceptor/dio_interceptor.dart';
import 'package:eighty_three_native_component/core/res/src/services/dependency_jnjection.dart';
import 'package:eighty_three_native_component/core/res/src/services/local_storage_service.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';

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
    //------------ Fetch ssl cetificate value from firebase -------------------- ///
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    remoteConfig.fetchAndActivate().then((value) {
      remoteConfig
          .setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      ))
          .then((value) async {

        /// ------ without SHA256 ------ ///

        final String sslKey = remoteConfig.getString("ssl");
        final String mockaSSLKey = remoteConfig.getString("ssl_mocka");
        await handleSSLUsingNormalCertificate(sslKey, mockaSSLKey);

        //handleSSL(sslKey,mockaSSLKey);
        /// ------ using sha256 ------ ///

        // final String sha256AliBaba = remoteConfig.getString("sha256_ali_baba");
        // final String sha256AliMocka = remoteConfig.getString("sha256_mocka");
        // handleSSLUsingSHA256(sha256AliBaba,sha256AliMocka);

      });
    });
  }

  handleSSL(String sslKey,String mockaSSL) async {
    // add ssl certificate
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      // final Uint8List certBytes = base64Decode(
      //     "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUR0RENDQXpxZ0F3SUJBZ0lTQk1jaEYzZlF5R3pscVNyaUVMQ0taZFRxTUFvR0NDcUdTTTQ5QkFNRE1ESXgKQ3pBSkJnTlZCQVlUQWxWVE1SWXdGQVlEVlFRS0V3MU1aWFFuY3lCRmJtTnllWEIwTVFzd0NRWURWUVFERXdKRgpNVEFlRncweU16QTFNakV3TlRJNE1qQmFGdzB5TXpBNE1Ua3dOVEk0TVRsYU1CSXhFREFPQmdOVkJBTVRCM0psCmN5NXBibU13V1RBVEJnY3Foa2pPUFFJQkJnZ3Foa2pPUFFNQkJ3TkNBQVRVRWlwOFNaZmZSMkFwRDFtSys2WVgKUERGYkVjeXh4YnRlTng5bVRuZHdCRFZwNG90b1FWa2J1SVNyLzh2cHR2MmgwTXBTZVNFZzVnZVRVV0lCZ0xITQpvNElDVGpDQ0Frb3dEZ1lEVlIwUEFRSC9CQVFEQWdlQU1CMEdBMVVkSlFRV01CUUdDQ3NHQVFVRkJ3TUJCZ2dyCkJnRUZCUWNEQWpBTUJnTlZIUk1CQWY4RUFqQUFNQjBHQTFVZERnUVdCQlNiMGQzVGFWTWg2eXR0N1JqYkNBRXEKcEFULzlEQWZCZ05WSFNNRUdEQVdnQlJhOCswci9EYkNOM201VWpEcVZHL1BWY3N1ckRCVkJnZ3JCZ0VGQlFjQgpBUVJKTUVjd0lRWUlLd1lCQlFVSE1BR0dGV2gwZEhBNkx5OWxNUzV2TG14bGJtTnlMbTl5WnpBaUJnZ3JCZ0VGCkJRY3dBb1lXYUhSMGNEb3ZMMlV4TG1rdWJHVnVZM0l1YjNKbkx6QWRCZ05WSFJFRUZqQVVnZ2txTG5KbGN5NXAKYm1PQ0IzSmxjeTVwYm1Nd1RBWURWUjBnQkVVd1F6QUlCZ1puZ1F3QkFnRXdOd1lMS3dZQkJBR0MzeE1CQVFFdwpLREFtQmdnckJnRUZCUWNDQVJZYWFIUjBjRG92TDJOd2N5NXNaWFJ6Wlc1amNubHdkQzV2Y21jd2dnRUZCZ29yCkJnRUVBZFo1QWdRQ0JJSDJCSUh6QVBFQWRnQjZNb3hVMkxjdHRpRHFPT0JTSHVtRUZuQXlFNFZOTzlJcndUcFgKbzFMclVnQUFBWWc4L3FML0FBQUVBd0JITUVVQ0lFaDZSNGpVdFRXVm9YVy9DKzVreExLOE94RlljOUV1cXVvTwpjQWJscW1xNEFpRUE2VTQzb3NmOXVXODU4N2JDbDBpYm1LWm9saVllbFhja3F5UXBpbFZ4NEprQWR3RG9QdERhClB2VUdOVExuVnlpOGlXdkpBOVBMMFJGcjdPdHA0WGQ5YlFhOWJnQUFBWWc4L3FMbUFBQUVBd0JJTUVZQ0lRQ3MKU1cwWHAyZ3pTU2tJYVpvUWxPSGFtdWlvMWJYWWlaSm1xYm8vd3YxRUpnSWhBTnFxRDBXUU9PbVFZamliN1kzRApRUHp5dDBpU3gwcmVVbDlublBFcEFYZkJNQW9HQ0NxR1NNNDlCQU1EQTJnQU1HVUNNRFZ4VUxHTkxGQk5sdTNPCiszcStLNGZVMjFMR2dTNkwrdW44TG5IenhFNkpxVzBRWWw1OFd6M1lMM3NlYmxOKzNRSXhBSzY5eHdNV1RDRkIKd0dBdTdpYTl4LzJoeHhTQkxZWFZrN3VZVTFST1dEejh0UjFBTVI2SEdZeVBlZ1JrTmdqZWN3PT0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQ==");

      final Uint8List certBytes = base64Decode(sslKey);
      final Uint8List mockaCertBytes = base64Decode(mockaSSL);
      // log('certBytes = ${certBytes}');
      final SecurityContext context = SecurityContext();
      client.badCertificateCallback = (cert, host, port) => false;
      context.setTrustedCertificatesBytes(certBytes);
      context.setTrustedCertificatesBytes(mockaCertBytes);
      return HttpClient(context: context);
    };
  }

  void handleSSLUsingSHA256(String sha256AliBaba, String sha256AliMocka){
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      HttpClient httpClient = HttpClient();
      //httpClient.findProxy = (uri) => "PROXY 192.168.1.2:8080";
      dio.interceptors.add(CertificatePinningInterceptor(allowedSHAFingerprints: [sha256AliBaba, sha256AliMocka]));
      /// badCertificateCallback should return false;
      httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
      return httpClient;
    };

  }

  Future<void> handleSSLUsingNormalCertificate(String sslKey, String mockaSSL) async {
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = (){
      final Uint8List certBytes = base64Decode(sslKey);
      final Uint8List mockaCertBytes = base64Decode(mockaSSL);
      final SecurityContext context = SecurityContext();
      context.setTrustedCertificatesBytes(certBytes);
      //context.setTrustedCertificatesBytes(mockaCertBytes);
      HttpClient httpClient = HttpClient(context: context);
      //httpClient.findProxy = (uri) => "PROXY 192.168.1.2:9090";

      /// badCertificateCallback should return false;
      httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
      return httpClient;
    };
  }
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
// }