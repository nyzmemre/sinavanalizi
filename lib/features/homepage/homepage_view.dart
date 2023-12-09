
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:kartal/kartal.dart';
import 'package:sinavanalizi/features/analysis/analysis_view.dart';
import 'package:sinavanalizi/features/homepage/homepage_view_model.dart';
import 'package:sinavanalizi/features/login/login_model.dart';
import 'package:sinavanalizi/features/login/login_view_model.dart';
import 'package:sinavanalizi/product/utilty/constants/color_constant.dart';

import '../classroom/classroom_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Padding(
            padding: context.padding.onlyTopHigh,
            child: Scaffold(
              appBar: AppBar(
                title: TabBar(
                 // overlayColor: Colors.red,
                  indicator: BoxDecoration(
                      color: Colors.teal),
                  dividerColor: Colors.deepOrange,
labelColor: ColorConstant.greyLight,
                  unselectedLabelColor: Colors.teal,
                  tabs: [
                    Padding(
                      padding: context.padding.medium,
                      child: Text('Analizlerim'),
                    ),Padding(
                      padding: context.padding.medium,
                      child: Text('Sınıflarım'),
                    ),
                  ],
                ),
              ),
              body: TabBarView(children: [
                AnalysisView(),
                ClassroomView(),
              ]),
            ),
          ),
        );
  }
}
