import 'package:flutter/material.dart';

class BranchViewModel extends ChangeNotifier {
  String? _branch;

  void changeBranch(String val) {
    _branch=val;
    notifyListeners();
  }

  String? get branch=>_branch;
}