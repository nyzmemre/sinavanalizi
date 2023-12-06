import 'package:flutter/material.dart';
import 'package:sinavanalizi/product/utilty/validators/textform_validators.dart';

import '../utilty/constants/color_constant.dart';
import '../utilty/constants/text_constant.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      required this.labelText,
      this.validator,
      this.keyboardType,
      this.controller,
      this.isVisible,
      this.enabled,
      this.passwordMatch});

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
      ///validasyon işlemlerinin tamamını textform_validators alanında topladım.
      validator: validator ??
          (value) {
            return TextFormValidator.validateNotEmpty(value, labelText) ??
                TextFormValidator.checkPasswordLenght(value, labelText) ??
                (labelText == TextConstant.mailAdress
                    ? TextFormValidator.validateEmail(value)
                    : null);
          },
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorConstant.white,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        labelText: labelText,
      ),
    );
  }
}
