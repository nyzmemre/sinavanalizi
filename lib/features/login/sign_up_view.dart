import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:provider/provider.dart';
import 'package:sinavanalizi/features/login/login_view_model.dart';
import 'package:sinavanalizi/product/utilty/constants/color_constant.dart';
import 'package:sinavanalizi/product/widgets/custom_dropdownmenu.dart';
import 'package:sinavanalizi/product/widgets/custom_dropdownmenu_branch.dart';
import 'package:sinavanalizi/product/widgets/custom_dropdownmenu_district.dart';
import 'package:sinavanalizi/product/widgets/custom_dropdownmenu_school.dart';
import 'package:sinavanalizi/product/widgets/custom_textformfield.dart';
import 'package:sinavanalizi/services/firebase_auth_services.dart';

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
  LoginViewModel _loginViewModel = LoginViewModel();

  @override
  void dispose() {
    nameCtrl.dispose();
    surnameCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    passwordAgainCtrl.dispose();
    schoolName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: context.padding.high,
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(TextConstant.signUp),
                context.sized.emptySizedHeightBoxLow,
                CustomTextFormField(
                  controller: nameCtrl,
                  labelText: TextConstant.name,
                ),
                context.sized.emptySizedHeightBoxLow,
                CustomTextFormField(
                  controller: surnameCtrl,
                  labelText: TextConstant.surname,
                ),
                context.sized.emptySizedHeightBoxLow,
                CustomTextFormField(
                  controller: emailCtrl,
                  labelText: TextConstant.mailAdress,
                ),
                context.sized.emptySizedHeightBoxLow,
                passwordColumn(),
                Consumer<LoginViewModel>(builder: (context, provider, _) {
                  return Row(
                    children: [
                      Checkbox(
                          value: provider.isVisible,
                          onChanged: (val) {
                            provider.visibleChange();
                          }),
                      (provider.isVisible)
                          ? Text('Şifreyi gizle')
                          : Text('Şifreyi göster'),
                    ],
                  );
                }),
                context.sized.emptySizedHeightBoxLow,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('cities')
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (snapshot.data == null ||
                              snapshot.data!.docs.isEmpty) {
                            return Center(child: Text('No data available'));
                          } else {
                            List<String> list =
                                snapshot.data!.docs.map((e) => e.id).toList();
                            list.insert(0,
                                'İl Seçiniz'); // "İl Seçiniz" ifadesini ekleyin
                            return CustomDropdownMenuCity(
                              list: list,
                            );
                          }
                        },
                      ),
                    ),
                    context.sized.emptySizedWidthBoxNormal,
                    Expanded(
                      child: Consumer<LoginViewModel>(
                        builder: (context, provider, _) {
                          return StreamBuilder<QuerySnapshot>(
                            stream: provider.city != null &&
                                    provider.city != 'İl Seçiniz'
                                ? FirebaseFirestore.instance
                                    .collection('cities')
                                    .doc(provider.city)
                                    .collection('districts')
                                    .snapshots()
                                : null,
                            builder: (context, snapshot) {
                              if (snapshot == null ||
                                  snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (snapshot.data == null ||
                                  snapshot.data!.docs.isEmpty) {
                                print(provider.district);
                                List<String> noList = ['İlçe Seçiniz'];
                                return CustomDropdownMenuDistrict(list: noList);
                              } else if (provider.city == 'İl Seçiniz') {
                                List<String> noList = ['İlçe Seçiniz'];
                                print(provider.district);
                                return CustomDropdownMenuDistrict(list: noList);
                              } else {
                                List<String> districtList = snapshot.data!.docs
                                    .map((e) => e.id)
                                    .toList();
                                districtList.insert(0, 'İlçe Seçiniz');

                                print(provider.district);

                                return CustomDropdownMenuDistrict(
                                    list: districtList);
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                context.sized.emptySizedHeightBoxLow,
                Align(
                  alignment: Alignment.center,
                  child:
                      Consumer<LoginViewModel>(builder: (context, provider, _) {
                    return StreamBuilder<QuerySnapshot>(
                      stream: provider.city != null &&
                              provider.city != 'İlçe Seçiniz'
                          ? FirebaseFirestore.instance
                              .collection('cities')
                              .doc(provider.city)
                              .collection('districts')
                              .doc(provider.district)
                              .collection('schools')
                              .snapshots()
                          : null,
                      builder: (context, snapshot) {
                        if (snapshot == null ||
                            snapshot.connectionState ==
                                ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.data == null ||
                            snapshot.data!.docs.isEmpty) {
                          List<String> noList = ['Okul Seçiniz'];
                          return CustomDropdownMenuSchool(list: noList);
                        } else if (provider.district == 'İlçe Seçiniz') {
                          List<String> noList = ['Okul Seçiniz'];
                          return CustomDropdownMenuSchool(list: noList);
                        } else {
                          List<String> schoolList =
                              snapshot.data!.docs.map((e) => e.id).toList();
                          schoolList.insert(0, 'Okul Seçiniz');

                          return CustomDropdownMenuSchool(list: schoolList);
                        }
                      },
                    );
                  }),
                ),
                context.sized.emptySizedHeightBoxLow,
                Consumer<LoginViewModel>(builder: (context, provider, _) {
                  return Column(
                    children: [
                      CustomTextFormField(
                          controller: schoolName,
                          enabled: provider.isSchoolFound,
                          validator: (provider.isSchoolFound) ? (value) {
                           if(schoolName.text.isEmpty){
                             return 'Lütfen forma okul ismini giriniz';
                           }else {
                             provider.schoolChange(schoolName.text);
                           }
                          } : (value){},

                          labelText: TextConstant.schoolName
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: provider.isSchoolFound,
                              onChanged: (val) {
                                provider.schoolFoundChange();
                              }),
                          (provider.isSchoolFound)
                              ? Text('Okulum Var')
                              : Text('Okulum Yok'),
                        ],
                      )
                    ],
                  );
                }),
                context.sized.emptySizedHeightBoxLow,
                Consumer<LoginViewModel>(
                  builder: (context, provider, _) {
                    return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('branches')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot == null ||
                            snapshot.connectionState ==
                                ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.data == null ||
                            snapshot.data!.docs.isEmpty) {
                          List<String> noList = ['Branş Seçiniz'];
                          return CustomDropdownMenuBranch(list: noList);
                        } else {
                          List<String> branchList =
                              snapshot.data!.docs.map((e) => e.id).toList();
                          branchList.insert(0, 'Branş Seçiniz');
                          return CustomDropdownMenuBranch(list: branchList);
                        }
                      },
                    );
                  },
                ),
                context.sized.emptySizedHeightBoxLow,
                Consumer<LoginViewModel>(
                  builder: (context, provider, _) {
                    return ElevatedButton(
                        onPressed: (provider.isClickButton)
                            ? null
                            : () async {
                                provider.buttonClickChange();
                                if (_key.currentState!.validate()) {
                                    if (provider.city != 'İl Seçiniz' &&
                                        provider.district != 'İlçe Seçiniz' &&
                                        provider.school != 'Okul Seçiniz' && provider.school.isNotEmpty && provider.branch!='Branş Seçiniz' && provider.branch.isNotEmpty) {

                                      await _loginViewModel
                                          .registerUserAndAddToFirestore(
                                              email: emailCtrl.text,
                                              password: passwordCtrl.text,
                                              name: nameCtrl.text,
                                              surname: surnameCtrl.text,
                                              branch: provider.branch,
                                              city: provider.city,
                                              district: provider.district,
                                              schoolID: 'schoolID',
                                              school: (!provider.isSchoolFound) ? provider.school : schoolName.text);
                                    } else {
                                      print('school: ${provider.school}');
                                      MotionToast.error(
                                        title: Text("Dikkat"),
                                        description: Text(
                                            "İl, ilçe, okul ve branş bilgilerinizi girdiğinizden emin olun!"),
                                        position: MotionToastPosition.center,
                                      ).show(context);
                                    }

                                } else {
                                  print(provider.school);
                                  print('bişeylee olupduru');
                                }

                                provider.buttonClickChange();
                              },
                        child: (provider.isClickButton)
                            ? CircularProgressIndicator()
                            : Text(TextConstant.signUp));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Consumer<LoginViewModel> passwordColumn() {
    return Consumer<LoginViewModel>(builder: (context, provider, _) {
      return Column(
        children: [
          CustomTextFormField(
            controller: passwordCtrl,
            isVisible: (provider.isVisible) ? false : true,
            labelText: TextConstant.password,
          ),
          context.sized.emptySizedHeightBoxLow,
          CustomTextFormField(
            controller: passwordAgainCtrl,
            isVisible: (provider.isVisible) ? false : true,
            validator: (value) {
              if (passwordCtrl.text != passwordAgainCtrl.text) {
                return TextConstant.passwordNotSame;
              }
            },
            labelText: TextConstant.passwordAgain,
          ),
        ],
      );
    });
  }
}
