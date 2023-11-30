import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class LoginViewModel extends ChangeNotifier {
  String? city;
  String? district;

  void cityChange(String value){
    city=value;
    notifyListeners();
  }

  void districtChange(String value){
    district=value;
    notifyListeners();
  }
}