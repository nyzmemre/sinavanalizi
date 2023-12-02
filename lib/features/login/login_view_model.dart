import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class LoginViewModel extends ChangeNotifier {
  ///Başlangıçta bu değerleri veriyorum
  ///Çünkü seçim yapılınca sonraki dropdown açılmalı, başta açılmamalı.
  String city='İl Seçiniz';
  String district='İlçe Seçiniz';

  void cityChange(String value){
    city=value;
    notifyListeners();
  }

  void districtChange(String value){
    district=value;
    notifyListeners();
  }
}