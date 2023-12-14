import 'dart:typed_data';

import 'package:excel/excel.dart' as excel;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class ReadDocument extends ChangeNotifier {
  String city = '';
  String district = '';
  String school='';
  String className = '';
  int studentCount = -1;
  List<String> studentNumbers = [];
  List<String> studentNames = [];
  List<String> studentSurnames = [];

  Future<void> processExcelFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xls', 'xlsx'],
    );

    if (result != null) {
      if (result.files.first.extension == 'xlsx') {
        Uint8List bytes = result.files.first.bytes!;
        excel.Excel excelDoc = excel.Excel.decodeBytes(bytes);

        bool isInStudentListSection = false;

        for (var table in excelDoc.tables.keys) {
          for (var row in excelDoc.tables[table]!.rows) {
            if (row[0] != null && row[0].toString().contains('VALİLİĞİ')) {
              // "VALİLİĞİ" bölümü
              city = row[0]
                  .toString()
                  .trim()
                  .split('VALİLİĞİ')
                  .first
                  .toString()
                  .split('T.C.')
                  .last
                  .trim();
            }

            if (row[0] != null &&
                row[0].toString().contains('Şubesi Sınıf Listesi')) {
              // "8. Sınıf / A Şubesi Sınıf Listesi" bölümü
              String bir =
                  row[0].toString().trim().split(' Şubesi Sınıf Listesi').first;
              String iki = bir.toString().split('/ ').last;
              String uc = bir
                  .toString()
                  .split('. Sınıf')
                  .first
                  .toString()
                  .trim()
                  .split('Müdürlüğü')
                  .last
                  .trim();
              className = uc + ' / ' + iki;
            }
            if (row[0] != null && row[0].toString().contains('Müdürlüğü')) {
              district = row[0]
                  .toString()
                  .split('VALİLİĞİ')
                  .last
                  .split(' /')
                  .first
                  .split('VALİLİĞİ')
                  .last
                  .trim();
            }

            if(row[0]!=null && row[0].toString().contains('Müdürlüğü')){
              school=row[0].toString().split('Müdürlüğü').first.split(' / ').last.trim();
            }

            // "S.No" veya "Öğrenci No" sütunlarından birini buldukça öğrenci listesi bölümü içindeyiz
            if (row.length > 2 &&
                    (row[2] != null &&
                        row[2].toString().contains('Öğrenci No')) ||
                (row[0] != null && row[0].toString().contains('S.No'))) {
              isInStudentListSection = true;
              continue; // "Öğrenci No" veya "S.No" başlığından sonrasını işle
            }

            // Öğrenci listesi bölümündeysek ve satırda veri varsa, öğrenci sayısını arttır
            if (isInStudentListSection &&
                row.length > 2 &&
                row[2] != null &&
                row[2].toString().isNotEmpty) {
              studentCount++;
            }

            if (row[0] != null && row[0].toString() == 'Öğrenci No') {
              // "Öğrenci No" sütunu
              for (int i = 1; i < row.length; i++) {
                if (row[i] != null) {
                  studentNumbers.add(row[i].toString());
                }
              }
            }
            if (row[0]?.value != null) {
              studentNumbers.add(row[2]!.value.toString());
              studentNames.add(row[5]!.value.toString());
              studentSurnames.add(row[9]!.value.toString());

              studentNumbers.removeWhere((element) => element == 'null');
              studentNames.removeWhere((element) => element == 'null');
              studentSurnames.removeWhere((element) => element == 'null');
            }
          }
        }

        // Öğrenci sayısı 0 ise listenin boş olduğunu belirle
        if (studentCount == -1) {
          print('Öğrenci listesi boş.');
        } else {
          // İşlenen verileri kullanabilirsiniz
          print('City: $city');
          print('District: $district');
          print('School: $school');
          print('Class: $className');
          print('Student Count: $studentCount');
          print('Student Numbers: $studentNumbers');
          print('Student Names: $studentNames');
          print('Student Surnames: $studentSurnames');

          print(studentNumbers.length.toString());
          print(studentNames.length.toString());
          print(studentSurnames.length.toString());
        }
      } else {
        MotionToast.error(
                position: MotionToastPosition.center,
                description:
                    Text('Lütfen dosya uzantısı XLSX olan bir belge seçiniz!'))
            .show(context);
      }
    } notifyListeners();
  }

  void clearData(){
    city = '';
    district = '';
    school='';
    className = '';
    studentCount = -1;
    studentNumbers = [];
    studentNames = [];
    studentSurnames = [];
  }
}
