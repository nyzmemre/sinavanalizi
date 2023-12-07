import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:provider/provider.dart';
import 'package:sinavanalizi/features/login/login_view_model.dart';
import 'package:sinavanalizi/product/utilty/constants/color_constant.dart';
import 'package:sinavanalizi/product/utilty/validators/textform_validators.dart';
import 'package:sinavanalizi/product/widgets/custom_textformfield.dart';
import 'package:sinavanalizi/services/firebase_auth_services.dart';

import '../../product/utilty/constants/text_constant.dart';
import '../../product/widgets/custom_dropdownmenu.dart';

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
  final confirmPasswordCtrl = TextEditingController();
  final schoolName = TextEditingController();
  LoginViewModel _loginViewModel = LoginViewModel();

  @override
  void dispose() {
    nameCtrl.dispose();
    surnameCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
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
                          ? Text(TextConstant.hidePassword)
                          : Text(TextConstant.showPassword),
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
                            .collection(TextConstant.dbTEXTCities)
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
                                TextConstant.selectCity); // "İl Seçiniz" ifadesini ekleyin
                            return Consumer<LoginViewModel>(
                              builder: (context, provider, _) {

                                return CustomDropdownMenu(
                                  initialSelection: list.first,
                                  list: list,
                                  function: provider.cityChange,
                                );
                              },
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
                                    provider.city != TextConstant.selectCity
                                ? FirebaseFirestore.instance
                                    .collection(TextConstant.dbTEXTCities)
                                    .doc(provider.city)
                                    .collection(TextConstant.dbTEXTDistricts)
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
                                List<String> noList = [TextConstant.selectDistrict];
                                return CustomDropdownMenu(
                                    initialSelection: TextConstant.selectDistrict,
                                    function: provider.districtChange,
                                    list: noList,
                                  enabled: (provider.city!=TextConstant.selectCity) ? true : false,
                                );
                              } else if (provider.city == TextConstant.selectCity) {
                                List<String> noList = [TextConstant.selectDistrict];
                                print(provider.district);
                                return CustomDropdownMenu(
                                    initialSelection: TextConstant.selectDistrict,
                                    function: provider.districtChange,
                                    list: noList,
                                  enabled: (provider.city!=TextConstant.selectCity) ? true : false,

                                );
                              } else {
                                List<String> districtList = snapshot.data!.docs
                                    .map((e) => e.id)
                                    .toList();
                                districtList.insert(0, TextConstant.selectDistrict);

                                print(provider.district);

                                return CustomDropdownMenu(
                                  initialSelection:  provider.district != TextConstant.selectDistrict ? provider.district : districtList.first,
                                    list: districtList,
                                  function: provider.districtChange,



                                );
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
                              provider.city != TextConstant.selectDistrict
                          ? FirebaseFirestore.instance
                              .collection(TextConstant.dbTEXTCities)
                              .doc(provider.city)
                              .collection(TextConstant.dbTEXTDistricts)
                              .doc(provider.district)
                              .collection(TextConstant.dbTEXTSchools)
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
                          List<String> noList = [TextConstant.selectSchool];
                          return CustomDropdownMenu (
                            initialSelection: TextConstant.selectSchool,
                              list: noList,
                            function: provider.schoolChange,
                            enabled: (provider.district!=TextConstant.selectDistrict && !provider.isSchoolFound) ? true : false,
                          );
                        } else if (provider.district == TextConstant.selectDistrict) {
                          List<String> noList = [TextConstant.selectSchool];
                          return CustomDropdownMenu (
                            initialSelection: TextConstant.selectSchool,
                            list: noList,
                            function: provider.schoolChange,
                            enabled: (provider.district!=TextConstant.selectDistrict && !provider.isSchoolFound) ? true : false,
                          );
                        } else {
                          List<String> schoolList =
                              snapshot.data!.docs.map((e) => e.id).toList();
                          schoolList.insert(0, TextConstant.selectSchool);

                          return CustomDropdownMenu(
                              list: schoolList,
                            function: provider.schoolChange,
                            initialSelection: provider.school != TextConstant.selectSchool ? provider.school : schoolList.first,

                          );
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
                             return TextConstant.pleaseEntryData;
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
                              ? const Text(TextConstant.haveSchool)
                              : const Text(TextConstant.dontHaveSchool),
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
                          List<String> noList = [TextConstant.selectBranch];
                          return CustomDropdownMenu (
                            initialSelection: TextConstant.selectBranch,
                            list: noList,
                            function: provider.branchChange,
                          );
                        } else {
                          List<String> branchList =
                              snapshot.data!.docs.map((e) => e.id).toList();
                          branchList.insert(0, TextConstant.selectBranch);
                          return CustomDropdownMenu(
                              initialSelection: provider.branch != TextConstant.selectBranch ? provider.branch : branchList.first,
                              function: provider.branchChange,
                              list: branchList
                          );
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
                                    if (provider.city != TextConstant.selectCity &&
                                        provider.district != TextConstant.selectDistrict &&
                                        provider.school != TextConstant.selectSchool && provider.school.isNotEmpty && provider.branch!=TextConstant.selectBranch && provider.branch.isNotEmpty) {

                                      await _loginViewModel
                                          .registerUserAndAddToFirestore(
                                        context: context,
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
                                      MotionToast.error(
                                        title: const Text(TextConstant.beCareful),
                                        description: const Text(TextConstant.cityDistrictSchoolBranch),
                                        position: MotionToastPosition.center,
                                      ).show(context);
                                    }

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
            controller: confirmPasswordCtrl,
            isVisible: (provider.isVisible) ? false : true,
            validator: (value) {
             return TextFormValidator.validatePasswordMatch(passwordCtrl.text, confirmPasswordCtrl.text);
            },
            labelText: TextConstant.passwordAgain,
          ),
        ],
      );
    });
  }
}
