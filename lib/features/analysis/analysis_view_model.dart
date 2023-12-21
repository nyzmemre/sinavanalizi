import 'package:flutter/material.dart';

class AnalysisViewModel extends ChangeNotifier {
  List<int> _rowTotalPoint=[];

  void addPoint(int lenght, int value, int index){
    List.filled(lenght, 0);
    rowTotalPoint[index] += (value ?? 0);
  }

  List<int> get rowTotalPoint=> _rowTotalPoint;
}