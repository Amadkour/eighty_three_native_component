library eighty_three_component;

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:eighty_three_native_component/core/res/src/configuration/top_level_configuration.dart';
import 'package:eighty_three_native_component/core/res/src/provider/api/interceptor/dio_interceptor.dart';
import 'package:eighty_three_native_component/core/res/src/services/dependency_jnjection.dart';
import 'package:eighty_three_native_component/core/res/src/services/local_storage_service.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';
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
  /// AliBaba
  if (!userOldServer) {
    return baseUrlModules.toString().split('.').last;

    /// Mocha
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
    dio.options.baseUrl = baseUrl ?? (userOldServer ? "https:/" : "http://gfi.group/api");
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
    dio.interceptors.add(
      DioInterceptor(
        networkError: networkError,
        onFetch: dio.fetch,
        setNetworkError: (value) => networkError = value,
        onRemoveSession: resetCallback ?? sl<LocalStorageService>().removeSession,
        readSecureKey: sl<LocalStorageService>().readSecureKey,
        writeSecureKey: sl<LocalStorageService>().writeSecureKey,
        userRole: userRole,
      ),
    );
    dio.interceptors.add(
      LogInterceptor(
        request: false,
        requestHeader: false,
        responseHeader: false,
      ),
    );
    //------------ Fetch ssl certificate value from firebase -------------------- ///
    firebaseRemoteConfig().then((value) => handleSSLUsingNormalCertificate(value, ''));
  }

  Future<void> handleSSLUsingNormalCertificate(String sslValue, String mockaSSL) async {
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        /// Don't trust any certificate just because their root cert is trusted.
        final HttpClient client = HttpClient(context: SecurityContext(withTrustedRoots: true));

        /// You can test the intermediate / root cert here. We just ignore it.
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      },
      validateCertificate: (cert, host, port) {
        if (cert == null) {
          return false;
        }
        // Validate it any way you want. Here we only check that
        // the fingerprint matches the OpenSSL SHA256.

        Uint8List newCer = base64Decode(sslValue.replaceAll("\n", ""));
        return sha256.convert(newCer).toString() == sha256.convert(cert.der).toString();
      },
    );
  }

  Future<String> firebaseRemoteConfig() async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

    ///fetch and activate
    await remoteConfig.fetchAndActivate();

    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(hours: 1)),
    );

    ///fetch ssl values
    final String sslValue = remoteConfig.getString("ssl");
    final String mockaSSLKey = remoteConfig.getString("ssl_mocka");
    return sslValue;
  }
}
