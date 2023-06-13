import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
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

  dio.httpClientAdapter = IOHttpClientAdapter()
    ..onHttpClientCreate = (_) {
      final SecurityContext context = SecurityContext(withTrustedRoots: false);
      context.useCertificateChainBytes(clientCertificate.buffer.asUint8List());
      HttpClient httpClient = HttpClient(context: context);
      httpClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return httpClient;
    };
}
