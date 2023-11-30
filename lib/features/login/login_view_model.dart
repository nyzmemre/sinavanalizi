import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class LoginViewModel extends ChangeNotifier {
  String? city;

  void cityChange(String value){
    city=value;
    print(city);
    notifyListeners();
  }
}