
import 'package:flutter/material.dart';

@immutable
class TextConstant{
  const TextConstant._();

  static const String appName='Sınav Analizi';

  ///screens
  static const String homepage='Ana Sayfa';
  static const String login='Giriş';
  static const String profile='Profil';
  static const String signUp='Kayıt Ol';
  static const String signIn='Giriş Yap';
  static const String password='Şifre';
  static const String passwordAgain='Şifre Tekrar';
  static const String mailAdress='Mail Adresi';
  static const String addClass='Sınıf Ekle';
  static const String addExam='Sınav Ekle';
  static const String addStudent='Öğrenci Ekle';
  static const String analysis='Analiz';
  static const String or='----- Veya -----';
  static const String name='İsim';
  static const String surname='Soyisim';
  static const String schoolName='Okul Adı';

  ///errorMessage
  static const String notEmpty='alanı boş olamaz.';
  static const String validateEmail='Lütfen geçerli bir mail adresi giriniz!';
  static const String validatePassword='Lütfen şifrenizi giriniz!';
  static const String passwordNotSame='Şifreleriniz aynı olmalıdır.';
  static const String mailNotEmptyError='Mail adresi boş olamaz!';
  static const String numberLengthERROR='11 karakterden az olamaz!';
  static const String groupIsContainERROR='Bu isimde zaten grup var!';
  static const String groupNotExistStudentERROR='Grupta Öğrenci Bulunamadı';
  static const String payNotFoundERROR='Ödeme Bulunamadı.';
  static const String infoNotFoundERROR='Bilgi Bulunamadı.';
  static const String hasError='Bir Sorun Oluştu.';
  static const String dataNotFoundERROR='Veri bulunamadı.';
  static const String selectCourseDay='Kurs Günlerini Seçiniz';

  ///texts
  static const String absentStudentText= 'Gelmeyen Öğrenci Sayısı';

  ///database collections
  static const String dbTEXTGroups='groups';

  ///FirebaseMessage
  static const String managerAddedTEXT='Yönetici Eklendi.';

}
