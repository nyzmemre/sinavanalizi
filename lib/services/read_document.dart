import 'dart:typed_data';
import 'dart:html' as html;
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart' as excel;

class ReadDocument {
  String city = '';
  String district = '';
  String school = '';
  String className = '';
  int studentCount = 0;
  List<String> studentNumbers = [];
  List<String> studentNames = [];
  List<String> studentSurnames = [];

  Future<void> processExcelFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null) {
      Uint8List bytes = result.files.first.bytes!;
      excel.Excel excelDoc = excel.Excel.decodeBytes(bytes);

      for (var table in excelDoc.tables.keys) {
        for (var row in excelDoc.tables[table]!.rows) {
          if (row[0] != null && row[0].toString().contains('VALİLİĞİ')) {
            // "VALİLİĞİ" bölümü
             city = row[0].toString().trim().split('VALİLİĞİ').first.toString().split('T.C.').last.trim(); // YALOVA VALİLİĞİ
          }

          if (row[0] != null && row[0].toString().contains('Şubesi Sınıf Listesi')) {
            // "8. Sınıf / A Şubesi Sınıf Listesi" bölümü
           String bir= row[0].toString().trim().split(' Şubesi Sınıf Listesi').first;
           String iki= bir.toString().split('/ ').last;
           String uc=bir.toString().split('. Sınıf').first.toString().trim().split('Müdürlüğü').last.trim();
           className=uc+' / '+iki;
          }

          if(row[0] !=null && row[0].toString().contains('Müdürlüğü')) {
            district=row[0].toString().split('VALİLİĞİ').last.split(' /').first.split('VALİLİĞİ').last.trim();
          }
/*

          if (row[0] != null && row[0].toString() == 'S.No') {
            // "S.No" sütunu (Öğrenci sayısı)
            //studentCount = int.parse(row[1].toString());
            studentCount=row[1].columnIndex;
          }
*/



                // 'S.No' sütunu indeksi (örneğin, 0) ile belirtilmelidir
                int sNoColumnIndex = 0;

                // Sadece sayısal değerleri içeren hücreleri say
                if (row[sNoColumnIndex] != null && row[sNoColumnIndex] is num ) {
                  studentCount++;
                }



            print('Toplam Veri Sayısı: $studentCount');

          if (row[0] != null && row[0].toString() == 'Öğrenci No') {
            // "Öğrenci No" sütunu
            for (int i = 1; i < row.length; i++) {
              if (row[i] != null) {
                studentNumbers.add(row[i].toString());
              }
            }
          }

          if (row[0] != null && row[0].toString() == 'Adı') {
            // "Adı" sütunu
            for (int i = 1; i < row.length; i++) {
              if (row[i] != null) {
                studentNames.add(row[i].toString());
              }
            }
          }

          if (row[0] != null && row[0].toString() == 'Soyadı') {
            // "Soyadı" sütunu
            for (int i = 1; i < row.length; i++) {
              if (row[i] != null) {
                studentSurnames.add(row[i].toString());
              }
            }
          }
        }
      }

      // İşlenen verileri kullanabilirsiniz
      print('City: $city');
      print('District: $district');
      print('Class: $className');
      print('Student Count: $studentCount');
      print('Student Numbers: $studentNumbers');
      print('Student Names: $studentNames');
      print('Student Surnames: $studentSurnames');
    }
  }
}
