import 'package:flutter/material.dart';

class AnalysisViewModel extends ChangeNotifier {
  List<int> _rowTotalPoint=[];
  int a = 0;

  void addList(List<int> list){
    _rowTotalPoint=list;
    notifyListeners();
  }


  set rowTotalPointSet(List<int> value) {
    _rowTotalPoint = value;
  }

  int _rakam=0;

  void updateResult(int index, int totalPoint){

    _rowTotalPoint.insert(index, totalPoint);
    notifyListeners();
  }

  List<int> get rowTotalPoint=> _rowTotalPoint;
  int get rakam=>_rakam;
}