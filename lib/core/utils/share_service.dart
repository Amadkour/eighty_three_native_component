import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShareService {
  Future<void> shareFile(Uint8List bytes, String fileExtension,
      {bool save = false}) async {
    final String name =
        "${DateTime.now().microsecondsSinceEpoch}.$fileExtension";
    String filePath = '';
    if (save) {
      if (Platform.isAndroid) {
        filePath = "${(await getExternalStorageDirectory())!.path}/$name";
      } else {
        filePath =
            "${(await getApplicationDocumentsDirectory()).path}/$name";
      }
    } else {
      filePath = "${(await getTemporaryDirectory()).path}/$name";
    }

    final File file = File(filePath);

    file.writeAsBytesSync(bytes);
    if (!save) {
      await Share.shareXFiles(<XFile>[XFile(filePath)]);
    }
  }
}
