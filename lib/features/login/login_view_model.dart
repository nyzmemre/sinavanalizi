import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class LoginViewModel extends ChangeNotifier {
  ///Başlangıçta bu değerleri veriyorum
  ///Çünkü seçim yapılınca sonraki dropdown açılmalı, başta açılmamalı.
  String _city='İl Seçiniz';
  String _district='İlçe Seçiniz';
  String _school='Okul Seçiniz';
  bool _isVisible=false;

  void visibleChange(){
    _isVisible=!_isVisible;
    notifyListeners();
  }

  void cityChange(String value){
    _city=value;
    notifyListeners();
  }

  void districtChange(String value){
    _district=value;
    notifyListeners();
  }

  String get city=>_city;
  String get district=>_district;
  String get school=>_school;
  bool get isVisible=>_isVisible;
}