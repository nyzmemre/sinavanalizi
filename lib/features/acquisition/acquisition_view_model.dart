import 'package:flutter/material.dart';

class AcquisitionViewModel extends ChangeNotifier{
  int? _numberOfQuess;
  String? _acquisition;

  void quessNum (int val){
    _numberOfQuess=val;
    notifyListeners();
  }

  void changeAcquisition (String val) {
    _acquisition=val;
    notifyListeners();
  }

  int? get numberOfQuess => _numberOfQuess;
  String? get acquisition => _acquisition;
}