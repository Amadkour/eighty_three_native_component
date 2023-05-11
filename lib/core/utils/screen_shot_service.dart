import 'dart:typed_data';

import 'package:eighty_three_native_component/core/res/src/services/dependency_jnjection.dart';

import 'package:eighty_three_native_component/core/shared/receipt/provider/model/receipt_model.dart';
import 'package:eighty_three_native_component/core/utils/pdf_service.dart';
import 'package:screenshot/screenshot.dart';

class ScreenShotService {
  final ScreenshotController controller = ScreenshotController();

  Future<Uint8List?> _convertWidgetToImage() async {
    final Uint8List? bytes = await controller.capture();
    return bytes;
  }

  Future<Uint8List?> _convertWidgetToPDf(ReceiptModel receiptModel,
      {String? qrData}) async {
    final Future<Uint8List> pdf =
        sl<PdfService>().generate(receiptModel, qrData: qrData);
    return pdf;
  }

  Future<Uint8List?> convertToBytes(String ext,
      {ReceiptModel? receiptModel, String? qrData}) {
    if (receiptModel != null) {
      return _convertWidgetToPDf(receiptModel, qrData: qrData);
    }
    return _convertWidgetToImage();
  }
}
