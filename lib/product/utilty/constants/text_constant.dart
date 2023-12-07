
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
  static const String schoolName='Okulunuz Listede Yoksa';
  static const String selectCity='İl Seçiniz';
  static const String selectDistrict='İlçe Seçiniz';
  static const String selectSchool='Okul Seçiniz';
  static const String selectBranch='Branş Seçiniz';
  static const String resetPassword='Şifreyi sıfırla.';


  ///errorMessage
  static const String beCareful='Dikkat';
  static const String pleaseEntryData='Lütfen forma okul ismini giriniz';
  static const String notEmpty='alanı boş olamaz.';
  static const String validateEmail='Lütfen geçerli bir mail adresi giriniz!';
  static const String validatePassword='Lütfen şifrenizi giriniz!';
  static const String passwordNotSame='Şifreleriniz aynı olmalıdır.';
  static const String mailNotEmptyError='Mail adresi boş olamaz!';
  static const String groupIsContainERROR='Bu isimde zaten grup var!';
  static const String groupNotExistStudentERROR='Grupta Öğrenci Bulunamadı';
  static const String payNotFoundERROR='Ödeme Bulunamadı.';
  static const String infoNotFoundERROR='Bilgi Bulunamadı.';
  static const String hasError='Bir Sorun Oluştu.';
  static const String dataNotFoundERROR='Veri bulunamadı.';
  static const String selectCourseDay='Kurs Günlerini Seçiniz';
  static const String cityDistrictSchoolBranch='İl, ilçe, okul ve branş bilgilerinizi girdiğinizden emin olun!';
  static const String hidePassword='Şifreyi gizle';
  static const String showPassword='Şifreyi göster';
  static const String haveSchool='Okulum Var';
  static const String dontHaveSchool='Okulum Yok';



  ///texts
  static const String absentStudentText= 'Gelmeyen Öğrenci Sayısı';

  ///database collections
  static const String dbTEXTCities='cities';
  static const String dbTEXTUsers='users';
  static const String dbTEXTDistricts='districts';
  static const String dbTEXTSchools='schools';
  static const String dbTEXTBranches='branches';
  static const String dbTEXTForceUpdate='forceupdate';

  ///FirebaseMessage
  static const String managerAddedTEXT='Yönetici Eklendi.';

}
