import 'package:flutter/material.dart';

import 'acquisition_model.dart';

class AcquisitionViewModel extends ChangeNotifier{
  List<String> _selectedAcquitions=[];
  List<String> _createExamSelectedAcquitionList=[];
  List<bool> _isIndexSelected=[];
  List<int> _numberOfQuessList=[];
  String _acquitionName='Kazanım Seçiniz';
    final List<Acquisition> acquisitionList=[
      Acquisition('Türkçe', '5', '1.1. Anlam'),
      Acquisition('Türkçe', '5', '1.2. Yüklem'),
      Acquisition('Türkçe', '6', '1.1. Eylem'),
      Acquisition('Türkçe', '6', '1.2. Nesne'),
      Acquisition('Türkçe', '7', '1.5. Özne'),
      Acquisition('Türkçe', '7', '1.6. Anlam'),
      Acquisition('Matematik', '1', '1.1. Rakam'),
      Acquisition('Matematik', '1', '1.2. Sayı'),
      Acquisition('Matematik', '1', '1.3. Esra'),
      Acquisition('Matematik', '1', '1.4. Kobe Braynt'),
      Acquisition('Matematik', '1', '1.5. Fatih'),
      Acquisition('Matematik', '5', '1.6. Sayı'),
      Acquisition('Matematik', '6', '1.1. Toplama'),
      Acquisition('Matematik', '6', '1.2. Çıkarma'),
      Acquisition('Matematik', '7', '1.5. Çarpma'),
      Acquisition('Matematik', '7', '1.6. Bölme'),
    ];

  List<String> getAcquisitionNameList(String branch, String grade) {
    ///aynı sayfada iki kez seçim yaparsa diye listeyi boşaltıyorum.
    _selectedAcquitions=[];
    acquisitionList.where((acquisition) {
      if (acquisition.acquisitionBranch == branch &&
          acquisition.acquisitionGrade == grade) {
        _selectedAcquitions.add(acquisition.acquisitionName);
      }
      return false;
    }).toList();

    return _selectedAcquitions;
  }

  void changeAcquitionName(String val) {
    _acquitionName=val;
    //_createExamSelectedAcquitionList.insert(index, val);
    print(_createExamSelectedAcquitionList);
    notifyListeners();
  }

  void createNumberOfQuessList(int val){
    _numberOfQuessList=List.generate(val, (index) => index+1);
    _isIndexSelected=List.generate(val, (index) => false);
    notifyListeners();
  }

  List<String> get selectedAcquitions => _selectedAcquitions;
  List<String> get createExamSelectedAcquitionList => _createExamSelectedAcquitionList;
  List<int> get numberOfQuessList=>_numberOfQuessList;
  List<bool> get isIndexSelected=>_isIndexSelected;
  String get acquitionName=>_acquitionName;
}



