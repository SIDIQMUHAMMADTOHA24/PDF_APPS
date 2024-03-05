import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class Service {
  Future<Uint8List> generatePdf() {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context content) {
        return pw.Center(child: pw.Text("Hello world"));
      },
    ));
    return pdf.save();
  }

  Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    final output = await getTemporaryDirectory();
    var filePath = "${output.path}/$fileName.pdf";
    final file = File(filePath);
    await file.writeAsBytes(byteList);
    await OpenFile.open(filePath);
  }

  Future<void> exportExcel() async {
    // Minta izin untuk menulis ke penyimpanan eksternal
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    Excel excel = Excel.createExcel();
    Sheet sheet = excel['Test Sheet'];

    var cell = sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)); //A1
    var cell2 = sheet.cell(CellIndex.indexByString("A2")); //A2

    cell.value = const TextCellValue("Ini index ke 1");
    cell2.value = const TextCellValue("Ini index ke 2");

    var fileBytes = excel.save();

    // Dapatkan direktori penyimpanan eksternal
    final directory = await getExternalStorageDirectory();
    String path = directory!.path;

    // Buat file Excel di direktori penyimpanan eksternal
    File(join('$path/output_file_name.xlsx'))
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);
  }
}
