import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import 'package:sinavanalizi/features/login/login_view_model.dart';
import 'package:sinavanalizi/product/widgets/custom_dropdownmenu.dart';
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('schools').snapshots(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                          return Center(child: Text('No data available'));
                        } else {
                          List<String> list =
                          snapshot.data!.docs.map((e) => e.id).toList();
                          list.insert(0, 'İl Seçiniz'); // "İl Seçiniz" ifadesini ekleyin
                          return CustomDropdownMenu(list: list);
                        }
                      },
                    ),
                  ),
                  context.sized.emptySizedWidthBoxNormal,
                  Expanded(
                    child: Consumer<LoginViewModel>(
                      builder: (context, provider, _) {
                        return StreamBuilder<QuerySnapshot>(
                          stream: provider.city != null && provider.city != 'İl Seçiniz'
                              ? FirebaseFirestore.instance
                              .collection('schools')
                              .doc(provider.city)
                              .collection('districts')
                              .snapshots()
                              : null,
                          builder: (context, snapshot) {
                            if (snapshot == null || snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            } else if (snapshot.data == null || snapshot.data!.docs.isEmpty || provider.city=='İl Seçiniz') {
                              List<String> noList=['İlçe Seçiniz'];
                              return CustomDropdownMenu(list: noList);
                            }
                            else {
                              List<String> districtList =
                              snapshot.data!.docs.map((e) => e.id).toList();

                              if (provider.city == 'İl Seçiniz') {
                                districtList.insert(0, 'İlçe Seçiniz');
                              }

                              return CustomDropdownMenu(list: districtList);
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              )
              ,




              context.sized.emptySizedHeightBoxNormal,
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
