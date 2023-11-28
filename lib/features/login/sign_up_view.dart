import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sinavanalizi/product/widgets/custom_textformfield.dart';

import '../../product/utilty/constants/text_constant.dart';

class SignUpView extends StatefulWidget {
  SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _key = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();

  final surnameCtrl = TextEditingController();

  final emailCtrl = TextEditingController();

  final passwordCtrl = TextEditingController();

  final passwordAgainCtrl = TextEditingController();

  String selectedCity = '';

  String selectedDistrict = '';

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
              const Text(TextConstant.signUp),
              context.sized.emptySizedHeightBoxNormal,
              CustomTextFormField(
                controller: nameCtrl,
                labelText: TextConstant.name,
              ),
              context.sized.emptySizedHeightBoxNormal,
              CustomTextFormField(
                controller: surnameCtrl,
                labelText: TextConstant.surname,
              ),
              context.sized.emptySizedHeightBoxNormal,
              CustomTextFormField(
                controller: emailCtrl,
                labelText: TextConstant.mailAdress,
              ),
              context.sized.emptySizedHeightBoxNormal,
              CustomTextFormField(
                controller: passwordCtrl,
                isVisible: true,
                labelText: TextConstant.password,
              ),
              context.sized.emptySizedHeightBoxNormal,
              CustomTextFormField(
                controller: passwordAgainCtrl,
                isVisible: true,
                validator: (value){
                  if(passwordCtrl.text != passwordAgainCtrl.text){
                    return TextConstant.passwordNotSame;
                  }
                },
                labelText: TextConstant.passwordAgain,
              ),
              context.sized.emptySizedHeightBoxNormal,
              Row(
                children: [
                  /*DropdownButton<String>(

                    value: selectedCity,
                    hint: Text('Select City'),
                    onChanged: (String? newValue) {

                      setState(() {
                        selectedCity = newValue!;
                        selectedDistrict = ''; // Reset district when city changes
                      });
                    },
                    items: ['City1', 'City2', 'City3'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),*/
                ],
              ),

              ElevatedButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {

                      //... do something
                    }
                  },
                  child: const Text(TextConstant.signUp)),
            ],
          ),
        ),
      ),
    ));
  }
}
