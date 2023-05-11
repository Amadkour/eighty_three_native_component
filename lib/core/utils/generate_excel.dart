import 'dart:io';

import 'package:eighty_three_native_component/core/shared/history/provider/model/transaction_model.dart';
import 'package:eighty_three_native_component/eighty_three_native_component.dart';
import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AnalyticsExcel {
  late Excel excel;

  generateExcel(
      {required List<TransactionModel> transactions,
      required String sheetName}) {
    excel = Excel.createExcel();
    Sheet sheetObject = excel[
        "$sheetName (${DateFormat("dd MMMM , hh:mm a").format(DateTime.now())})"];

    sheetObject.insertColumn(0);
    sheetObject.insertColumn(1);
    sheetObject.insertColumn(2);
    sheetObject.insertColumn(3);
    sheetObject.insertColumn(4);
    sheetObject.insertColumn(4);

    List<String> dataList = [
      tr("operation_number"),
      tr("date"),
      tr("reference"),
      tr("operation_name"),
      tr("method"),
      tr("amount")
    ];

    CellStyle cellStyle = CellStyle(
        fontFamily: getFontFamily(FontFamily.Calibri),
        verticalAlign: VerticalAlign.Center,
        horizontalAlign: HorizontalAlign.Center,
        backgroundColorHex: "FFd4ECE4",
        textWrapping: TextWrapping.WrapText);
    CellStyle cellStyle2 = CellStyle(
      fontFamily: getFontFamily(FontFamily.Calibri),
      verticalAlign: VerticalAlign.Center,
      horizontalAlign: HorizontalAlign.Center,
      textWrapping: TextWrapping.WrapText,
    );

    for (int i = 0; i < dataList.length; i++) {
      var cell = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0));
      cell.cellStyle = cellStyle;
    }
    sheetObject.insertRowIterables(dataList, 0);
    for (int j = 0; j < transactions.length; j++) {
      for (int i = 0; i < dataList.length; i++) {
        var cell = sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: j + 1));
        cell.cellStyle = cellStyle2;
      }
      sheetObject.insertRowIterables(
          transactions[j].toJson(j + 1).values.toList(), j + 1);
    }

    excel.setDefaultSheet(sheetObject.sheetName);

    saveExcel(sheetName);
  }

  void saveExcel(String fileName) async {
    await requestPermissions();
    var fileBytes = excel.save();
    bool dirDownloadExists = true;
    String directory;
    if (Platform.isIOS) {
      directory = (await getApplicationDocumentsDirectory()).path;
    } else {
      directory = "/storage/emulated/0/Download/";
      dirDownloadExists = await Directory(directory).exists();
      if (dirDownloadExists) {
        directory = "/storage/emulated/0/Download/";
      } else {
        directory = "/storage/emulated/0/Downloads/";
      }
    }
    final filePath = directory;
    Directory(filePath)
        .create(recursive: true)
        .then((Directory directory) async {
      File(join('${directory.path}/$fileName.xlsx'))
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes!);
    });
  }
}

Future<void> requestPermissions() async {
  if (Platform.isAndroid) {
    if (await Permission.manageExternalStorage.isDenied) {
      PermissionStatus status =
          await Permission.manageExternalStorage.request();
      if (status.isDenied) {
        return;
      }
    }
  }
}
