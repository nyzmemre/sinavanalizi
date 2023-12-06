import 'package:flutter/material.dart';
import 'package:sinavanalizi/product/utilty/constants/text_constant.dart';

@immutable
class TextFormValidator {
  const TextFormValidator._();

  ///formun boş olup olmadığını kontrol ediyor.
  static String? validateNotEmpty(String? value, String labelText){
    if(value==null || value.isEmpty) {
      return '$labelText ${TextConstant.notEmpty}';
    }
    return null;
  }

  ///parola uzunluğunun en az 8 karakter olmasını sağlıyor.
  static String? checkPasswordLenght(String? value, String labelText){
    if(labelText==TextConstant.password && value!=null) {
      if(value!.length<7){
        return 'Şifre en az 8 haneli olmalıdır';
      }
    }
    return null;
  }

  ///email adresinin doğruluğunu kontrol ediyor.
  static String? validateEmail(String? value) {
    if(value != null && (!value.contains('@') || !value.contains('.com'))){
      return TextConstant.validateEmail;
    }
    return null;
  }

  ///parolalar aynı mı kontrol ediyor.
  static String? validatePasswordMatch(String password, String confirmPassword){
    if(password!=confirmPassword) {
      return TextConstant.passwordNotSame;
    }
    return null;
  }
}