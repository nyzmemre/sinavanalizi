import 'dart:typed_data';
import 'dart:html' as html; // web için HTML kütüphanesi
import 'package:excel/excel.dart' as excel;
import 'package:file_picker/file_picker.dart';
import 'package:sinavanalizi/services/read_document.dart';

class UploadFile{
  Future<void> uploadAndReadExcel() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
    );

    if (result != null) {
      Uint8List bytes = result.files.first.bytes!;
      excel.Excel excelDoc = excel.Excel.decodeBytes(bytes);

      for (var table in excelDoc.tables.keys) {
        print(table); // Sayfa adı
        print(excelDoc.tables[table]!.maxRows);

        for (var row in excelDoc.tables[table]!.rows) {
          // Her bir satırı işleyin
          for (var cell in row) {
            print('$cell');
          }
        }
      }
    }
    ReadDocument().processExcelFile();
  }

}