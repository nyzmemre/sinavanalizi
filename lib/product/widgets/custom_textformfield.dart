import 'package:flutter/material.dart';

import '../utilty/constants/color_constant.dart';
import '../utilty/constants/text_constant.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({super.key, required this.labelText, this.validator, this.keyboardType, this.controller, this.isVisible, this.enabled, this.passwordMatch});
  // ignore: strict_raw_type
  final String labelText;
  final FormFieldValidator<String>? validator;
  final bool? isVisible;
  final TextInputType? keyboardType;
  final bool? enabled;
  final String? passwordMatch;

  TextEditingController? controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return TextFormField(

      obscureText: isVisible ?? false,
      controller: controller,
      enabled: enabled ?? true,
      keyboardType: keyboardType,
      validator: validator ?? (value){
        if (validator != null) {
          return validator!(value);
        }

        if(value==null || value=='') {
          return '$labelText ${TextConstant.notEmpty}';
        }
        else if (keyboardType==TextInputType.number){
          if(controller!.text.length < 11) {
            return '$labelText ${TextConstant.numberLengthERROR}';
          }
        }
        else if(labelText== TextConstant.password){
          if(value.length<7){
            return 'Şifre en az 8 haneli olmalıdır';
          }
        }
        else if(labelText==TextConstant.mailAdress) {
          if (!value.contains('@') ||
              !value.contains('.com')) {
            return TextConstant.validateEmail;
          }
          return null;
        }
      },
      decoration:  InputDecoration(
        filled: true,
        fillColor: ColorConstant.white,
        border: const OutlineInputBorder(
          borderRadius:  BorderRadius.all( Radius.circular(5),),),
        enabledBorder: const OutlineInputBorder(
            borderSide:  BorderSide(color: ColorConstant.black)
        ),
        labelText: labelText,
      ),
    );
  }
}