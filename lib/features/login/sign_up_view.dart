import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import 'package:sinavanalizi/features/login/login_view_model.dart';
import 'package:sinavanalizi/product/utilty/constants/color_constant.dart';
import 'package:sinavanalizi/product/widgets/custom_dropdownmenu.dart';
import 'package:sinavanalizi/product/widgets/custom_dropdownmenu_district.dart';
import 'package:sinavanalizi/product/widgets/custom_dropdownmenu_school.dart';
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
  final schoolName = TextEditingController();
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
              Consumer<LoginViewModel>(builder: (context, provider,_){
    return Column(
      children: [
        CustomTextFormField(
                    controller: passwordCtrl,
                    isVisible: (provider.isVisible) ? false : true,
                    labelText: TextConstant.password,
                  ),context.sized.emptySizedHeightBoxNormal,
        CustomTextFormField(
          controller: passwordAgainCtrl,
          isVisible: (provider.isVisible) ? false : true,
          validator: (value){
            if(passwordCtrl.text != passwordAgainCtrl.text){
              return TextConstant.passwordNotSame;
            }
          },
          labelText: TextConstant.passwordAgain,
        ),
      ],
    );}),

              Consumer<LoginViewModel>(builder: (context, provider,_){
                return Row(
                  children: [

                    Checkbox(
                        value: provider.isVisible, onChanged: (val){
                      provider.visibleChange();
                    }),
                    (provider.isVisible) ? Text('Şifreyi gizle') : Text('Şifreyi göster'),
                  ],
                );
              }),
              context.sized.emptySizedHeightBoxNormal,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('cities').snapshots(),
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
                          return CustomDropdownMenuCity(list: list,);
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
                              .collection('cities')
                              .doc(provider.city)
                              .collection('districts')
                              .snapshots()
                              : null,
                          builder: (context, snapshot) {
                            if (snapshot == null || snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            } else if (snapshot.data == null || snapshot.data!.docs.isEmpty  ) {
                              print(provider.district);
                              List<String> noList=['İlçe Seçiniz'];
                              return CustomDropdownMenuDistrict(list: noList);
                            }else if (provider.city=='İl Seçiniz'){
                              List<String> noList=['İlçe Seçiniz'];
                              print(provider.district);
                              return CustomDropdownMenuDistrict(list: noList);
                            }
                            else {
                              List<String> districtList =
                              snapshot.data!.docs.map((e) => e.id).toList();

print(provider.district);

                              return  CustomDropdownMenuDistrict(list: districtList);
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              context.sized.emptySizedHeightBoxNormal,
              Align(
  alignment: Alignment.centerLeft,
  child:   Consumer<LoginViewModel>(builder: (context, provider,_){
    return StreamBuilder<QuerySnapshot>(
      stream: provider.city != null && provider.city != 'İlçe Seçiniz'
          ? FirebaseFirestore.instance
          .collection('cities')
          .doc(provider.city)
          .collection('districts')
      .doc(provider.district).collection('schools')
          .snapshots()
          : null,
      builder: (context, snapshot) {
        if (snapshot == null || snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data == null || snapshot.data!.docs.isEmpty  ) {
          print(provider.district);
          List<String> noList=['Okul Seçiniz'];
          return CustomDropdownMenuSchool(list: noList);
        }else if (provider.district=='İlçe Seçiniz'){
          List<String> noList=['Okul Seçiniz'];
          print(provider.district);
          return CustomDropdownMenuSchool(list: noList);
        }
        else {
          List<String> schoolList =
          snapshot.data!.docs.map((e) => e.id).toList();

          print(provider.district);

          return  CustomDropdownMenuSchool(list: schoolList);
        }
      },
    );
  }),
),

   context.sized.emptySizedHeightBoxNormal,
              Consumer<LoginViewModel>(builder: (context, provider,_){
                return Column(
                  children: [
                    CustomTextFormField(
                      controller: schoolName,
                      eneblad: provider.isSchoolFound,
                      labelText: TextConstant.schoolName,
                    ),
                    Row(
                      children: [

                        Checkbox(
                            value: provider.isSchoolFound, onChanged: (val){
                          provider.schoolFoundChange();
                        }),
                        (provider.isSchoolFound) ? Text('Okulum Var') : Text('Okulum Yok'),
                      ],
                    )
                  ],
                );}),
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
