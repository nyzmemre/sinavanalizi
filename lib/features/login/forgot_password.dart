import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import 'package:sinavanalizi/features/login/login_view_model.dart';

import '../../product/widgets/custom_textformfield.dart';
import '../../product/utilty/constants/text_constant.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({Key? key}) : super(key: key);
  TextEditingController _emailCtrl=TextEditingController();
  LoginViewModel _viewModel=LoginViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: context.padding.high,
          child: Column(
            children: [
              CustomTextFormField(
                controller: _emailCtrl,
                labelText: TextConstant.mailAdress,
              ),
              context.sized.emptySizedHeightBoxLow,
              Consumer<LoginViewModel>(
                builder: (context, provider, _) {
                  return ElevatedButton(onPressed: ()async {
                    provider.buttonClickChange();
                    await _viewModel.resetPassword(context, _emailCtrl.text);
provider.buttonClickChange();
                  }, child: provider.isClickButton ? CircularProgressIndicator() :  Text(TextConstant.resetPassword));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
