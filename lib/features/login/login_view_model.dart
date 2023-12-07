import 'dart:js_util';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:sinavanalizi/features/homepage/homepage_view.dart';
import 'package:sinavanalizi/services/firebase_auth_services.dart';

class LoginViewModel extends ChangeNotifier {
  FirebaseAuthServices _authServices=FirebaseAuthServices();


  ///Başlangıçta bu değerleri veriyorum
  ///Çünkü seçim yapılınca sonraki dropdown açılmalı, başta açılmamalı.
  String _city='İl Seçiniz';
  String _district='İlçe Seçiniz';
  String _school='Okul Seçiniz';
  String _branch='Branş Seçiniz';
  bool _isVisible=false;
  bool _isSchoolFound=false;
  bool _isClickButton=false;


  void schoolFoundChange(){
    _isSchoolFound=!_isSchoolFound;
    notifyListeners();
  }
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

  void schoolChange(String value){
    _school=value;
    notifyListeners();
  }

  void branchChange(String value){
    _branch=value;
    notifyListeners();
  }

  void buttonClickChange(){
    _isClickButton=!_isClickButton;
    notifyListeners();
  }

  Future<void> resetPassword(BuildContext context, String email) async {
    await _authServices.resetPassword(email).then((value) => MotionToast.success(
      // title: Text('Başarılı'),
      description: Text('Parolayı sıfırlamak için mail adresinizi kontrol edin.'),
    ).show(context) );

  }

  Future<void> registerUserAndAddToFirestore({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String surname,
    required String branch,
    required String city,
    required String district,
    required String schoolID,
    required String school,
  }) async {
    try {
      // Firebase Authentication ile kullanıcı oluşturma
      await _authServices.singUp(email, password);

      // Oluşturulan kullanıcının UID'sini al
      String uid = _authServices.getUserUid() ?? '';

      // Firestore bağlantısı
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Kullanıcı verilerini Firestore'a ekleme
      await firestore.collection('users').doc(uid).set({
        'name': name,
        'surname': surname,
        'email': email,
        'branch': branch,
        'city': city,
        'district': district,
        'schoolID': schoolID,
        'school': school,
      });
      MotionToast.success(
        title: Text('Tebrikler'),
        description: Text('Kayıt başarıyla olşturuldu.'),
      ).show(context);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
      print('Kullanıcı başarıyla oluşturuldu ve Firestore\'a eklendi.');
    } catch (e) {
      MotionToast.error(
        title: Text('Hata'),
        description: Text('Bir sorun var gibi görünüyor. $e'),
      ).show(context);
      print('Hata oluştu: $e');
    }
  }






  String get city=>_city;
  String get district=>_district;
  String get school=>_school;
  String get branch=>_branch;
  bool get isVisible=>_isVisible;
  bool get isSchoolFound=>_isSchoolFound;
  bool get isClickButton=>_isClickButton;
}

