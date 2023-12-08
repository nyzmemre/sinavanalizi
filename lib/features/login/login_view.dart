import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:provider/provider.dart';
import 'package:sinavanalizi/features/homepage/homepage_view.dart';
import 'package:sinavanalizi/features/login/login_view_model.dart';
import 'package:sinavanalizi/features/login/sign_up_view.dart';
import 'package:sinavanalizi/product/utilty/constants/text_constant.dart';
import 'package:sinavanalizi/product/utilty/validators/textform_validators.dart';
import 'package:sinavanalizi/product/widgets/custom_textformfield.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final _key = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  LoginViewModel _loginViewModel=LoginViewModel();
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
              Consumer<LoginViewModel>(
                builder: (context, provider, _) {
                  return CustomTextFormField(
                    labelText: TextConstant.password,
                    isVisible: !provider.isVisible,
                    controller: passwordCtrl,
                  );
                },
              ),
              Consumer<LoginViewModel>(builder: (context, provider, _) {
                return Row(
                  children: [
                    Checkbox(
                        value: provider.isVisible,
                        onChanged: (val) {
                          provider.visibleChange();
                        }),
                    (provider.isVisible)
                        ? Text(TextConstant.hidePassword)
                        : Text(TextConstant.showPassword),
                  ],
                );
              }),
              context.sized.emptySizedHeightBoxLow,
              Consumer<LoginViewModel>(
                builder: (context, provider, _) {
                  return ElevatedButton(onPressed: (provider.isClickButton) ? null : () {
                    if(_key.currentState!.validate())
                      {
                        provider.buttonClickChange();
                        provider.singIn(context, emailCtrl.text, passwordCtrl.text);
                        provider.buttonClickChange();

                      }
                  }, child:  (provider.isClickButton) ? const CircularProgressIndicator(): const Text(TextConstant.signIn));
                },
              ),
              context.sized.emptySizedHeightBoxLow,
              const Text(TextConstant.or),
              context.sized.emptySizedHeightBoxLow,
              TextButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpView()));
              }, child: const Text(TextConstant.signUp),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
