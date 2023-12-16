import 'dart:js_util';

import 'package:flutter/material.dart';

class ExamViewModel extends ChangeNotifier {
  String _periodNum='1';
  String _numberOfQuess='8';
  String _examNum='2';



  void changePeriodNum(String val){
    _periodNum=val;
    notifyListeners();
  }

  void changeNumberOfQuess(String val){
    _numberOfQuess=val;
    notifyListeners();
  }
  void changeExamNum(String val){
    _examNum=val;
    notifyListeners();
  }

  String get numberOfQuess => _numberOfQuess;
  String get periodNum => _periodNum;
  String get examNum => _examNum;
}