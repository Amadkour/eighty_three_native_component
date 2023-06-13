import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:eighty_three_native_component/core/res/src/configuration/top_level_configuration.dart';
import 'package:flutter/services.dart';

// Future<SecurityContext> get globalContext async {
//   final ByteData sslCert = await rootBundle.load('assets/certificates/res.inc');
//   SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
//   securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
//   return securityContext;
// }

// Future<http.Client> getSSLPinningClient() async {
//   HttpClient client = HttpClient(context: await globalContext);
//   client.badCertificateCallback =
//       (X509Certificate cert, String host, int port) => false;
//   IOClient ioClient = IOClient(client);
//   return ioClient;
// }

Future<void> handleSSL(Dio dio) async {
  ByteData clientCertificate =
      await rootBundle.load("assets/certificates/res-app.pem");
  ByteData mockaCertificate =
      await rootBundle.load("assets/certificates/res-mocka.pem");

  dio.httpClientAdapter = IOHttpClientAdapter()
    ..onHttpClientCreate = (_) {
      final SecurityContext context = SecurityContext(withTrustedRoots: false);
      if (userOldServer) {
        context.useCertificateChainBytes(mockaCertificate.buffer.asUint8List());
      } else {
        context
            .useCertificateChainBytes(clientCertificate.buffer.asUint8List());
      }
      HttpClient httpClient = HttpClient(context: context);
      httpClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return httpClient;
    };
}


/**
 * 
 * import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:eighty_three_native_component/core/res/src/configuration/top_level_configuration.dart';
import 'package:flutter/services.dart';

// Future<SecurityContext> get globalContext async {
//   final ByteData sslCert = await rootBundle.load('assets/certificates/res.inc');
//   SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
//   securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
//   return securityContext;
// }

// Future<http.Client> getSSLPinningClient() async {
//   HttpClient client = HttpClient(context: await globalContext);
//   client.badCertificateCallback =
//       (X509Certificate cert, String host, int port) => false;
//   IOClient ioClient = IOClient(client);
//   return ioClient;
// }

Future<void> handleSSL(Dio dio) async {
  final SecurityContext context = SecurityContext.defaultContext;

  Uint8List clientCertificate =
      File("assets/certificates/res-app.pem").readAsBytesSync();
  Uint8List mockaCertificate =
      File("assets/certificates/res-mocka.pem").readAsBytesSync();

  context.setTrustedCertificatesBytes(clientCertificate);
  context.setTrustedCertificatesBytes(mockaCertificate);
  dio.httpClientAdapter = IOHttpClientAdapter()
    ..onHttpClientCreate = (_) {
      final SecurityContext context = SecurityContext(withTrustedRoots: false);
      if (userOldServer) {
        context.useCertificateChainBytes(mockaCertificate.buffer.asUint8List());
      } else {
        context
            .useCertificateChainBytes(clientCertificate.buffer.asUint8List());
      }
      HttpClient httpClient = HttpClient(context: context);
      httpClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return httpClient;
    };
}

 */



/**
 * import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:eighty_three_native_component/core/res/src/configuration/top_level_configuration.dart';
import 'package:flutter/services.dart';

// Future<SecurityContext> get globalContext async {
//   final ByteData sslCert = await rootBundle.load('assets/certificates/res.inc');
//   SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
//   securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
//   return securityContext;
// }

// Future<http.Client> getSSLPinningClient() async {
//   HttpClient client = HttpClient(context: await globalContext);
//   client.badCertificateCallback =
//       (X509Certificate cert, String host, int port) => false;
//   IOClient ioClient = IOClient(client);
//   return ioClient;
// }

Future<void> handleSSL(Dio dio) async {
  ByteData clientCertificate =
      await rootBundle.load("assets/certificates/res-app.pem");
  ByteData mockaCertificate =
      await rootBundle.load("assets/certificates/res-mocka.pem");

  print('clientCertificate = $clientCertificate');
  print('mockaCertificate = $mockaCertificate');
  print('we are in ${userOldServer ? 'Mocka' : 'Alibaba'}');
  dio.httpClientAdapter = IOHttpClientAdapter()
    ..onHttpClientCreate = (_) {
      final SecurityContext context = SecurityContext(withTrustedRoots: false);
      if (userOldServer) {
        print('userOldServer = $userOldServer');
        context.useCertificateChainBytes(mockaCertificate.buffer.asUint8List());
      } else {
        print('userOldServer = $userOldServer');
        context
            .useCertificateChainBytes(clientCertificate.buffer.asUint8List());
      }
      HttpClient httpClient = HttpClient(context: context);
      httpClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return httpClient;
    };
}









/**OLD
 * 
 * import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:eighty_three_native_component/core/res/src/configuration/top_level_configuration.dart';
import 'package:flutter/services.dart';

// Future<SecurityContext> get globalContext async {
//   final ByteData sslCert = await rootBundle.load('assets/certificates/res.inc');
//   SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
//   securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
//   return securityContext;
// }

// Future<http.Client> getSSLPinningClient() async {
//   HttpClient client = HttpClient(context: await globalContext);
//   client.badCertificateCallback =
//       (X509Certificate cert, String host, int port) => false;
//   IOClient ioClient = IOClient(client);
//   return ioClient;
// }

Future<void> handleSSL(Dio dio) async {
  final SecurityContext context = SecurityContext.defaultContext;

  Uint8List clientCertificate =
      File("assets/certificates/res-app.pem").readAsBytesSync();
  Uint8List mockaCertificate =
      File("assets/certificates/res-mocka.pem").readAsBytesSync();

  context.setTrustedCertificatesBytes(clientCertificate);
  context.setTrustedCertificatesBytes(mockaCertificate);
  dio.httpClientAdapter = IOHttpClientAdapter()
    ..onHttpClientCreate = (_) {
      final SecurityContext context = SecurityContext(withTrustedRoots: false);
      if (userOldServer) {
        context.useCertificateChainBytes(mockaCertificate.buffer.asUint8List());
      } else {
        context
            .useCertificateChainBytes(clientCertificate.buffer.asUint8List());
      }
      HttpClient httpClient = HttpClient(context: context);
      httpClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return httpClient;
    };
}

 */
 */