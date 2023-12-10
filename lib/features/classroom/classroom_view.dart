import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sinavanalizi/product/utilty/constants/text_constant.dart';

import '../../product/utilty/constants/color_constant.dart';
import '../../product/widgets/custom_add_widget.dart';

class ClassroomView extends StatelessWidget {
  const ClassroomView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CustomAddWidget(
        text: TextConstant.addClass,
        widget: Text(''),
      ))
    );
  }
}
