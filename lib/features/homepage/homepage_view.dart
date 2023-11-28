
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:sinavanalizi/features/homepage/homepage_view_model.dart';
import 'package:sinavanalizi/features/login/login_model.dart';
import 'package:sinavanalizi/features/login/login_view_model.dart';
import 'package:sinavanalizi/product/utilty/constants/color_constant.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 100,
          width: 100,
          color: ColorConstant.greyLight,
          child: Text('Başla')
        ),
      ),
    );
  }
}
