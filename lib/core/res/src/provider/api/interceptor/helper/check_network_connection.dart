import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> isConnectedToNetwork () async {
  return <ConnectivityResult>[ConnectivityResult.mobile,ConnectivityResult.wifi].contains(await Connectivity().checkConnectivity());
}

Future<bool>checkInternetConnection() async {
  try {
    final List<InternetAddress> result = await InternetAddress.lookup("google.com");
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
    else{
      return false;
    }
  } on SocketException catch (_) {
    return false;
  }
}
