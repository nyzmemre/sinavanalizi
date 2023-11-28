import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:sinavanalizi/features/homepage/homepage_view.dart';
import 'package:sinavanalizi/product/utilty/constants/text_constant.dart';

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
              TextFormField(
                validator: (value){
                  if(value!=null) {
                    if(value.length<3)
                      {return TextConstant.mailNotEmptyError;}
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: TextConstant.mailAdress,
                ),
                controller: emailCtrl,
              ),
              context.sized.emptySizedHeightBoxLow,
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: TextConstant.password,
                ),
                validator: (value){
                  if(value!=null) {
                    if(value.length<6)
                    {return 'Şifre 6 karakterden az olamaz!';}
                  }
                },
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
