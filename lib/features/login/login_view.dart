import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:sinavanalizi/features/homepage/homepage_view.dart';
import 'package:sinavanalizi/product/utilty/constants/text_constant.dart';
import 'package:sinavanalizi/product/utilty/validators/textform_validators.dart';
import 'package:sinavanalizi/product/widgets/custom_textformfield.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final _key = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: context.padding.high,
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(TextConstant.signIn),
              context.sized.emptySizedHeightBoxLow,
              CustomTextFormField(
                labelText: TextConstant.mailAdress,

                controller: emailCtrl,
              ),
              context.sized.emptySizedHeightBoxLow,
              CustomTextFormField(
                labelText: TextConstant.password,

                controller: passwordCtrl,
              ),
              context.sized.emptySizedHeightBoxLow,
              ElevatedButton(onPressed: () {
                if(_key.currentState!.validate())
                  {
                   //... do something
                  }
              }, child: const Text(TextConstant.signIn)),
              context.sized.emptySizedHeightBoxLow,
              const Text(TextConstant.or),
              context.sized.emptySizedHeightBoxLow,
              TextButton(onPressed: () {}, child: const Text(TextConstant.signUp),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
