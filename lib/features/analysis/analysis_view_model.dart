import 'package:flutter/material.dart';

class AnalysisViewModel extends ChangeNotifier {
  List<int> _rowTotalPoint=[];
  int _rakam=0;

  void updateResult(){

    _rakam+=1;
    notifyListeners();
  }

  List<int> get rowTotalPoint=> _rowTotalPoint;
  int get rakam=>_rakam;
}