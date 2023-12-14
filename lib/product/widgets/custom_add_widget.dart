import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:sinavanalizi/services/read_document.dart';
import '../utilty/constants/color_constant.dart';

class CustomAddWidget extends StatelessWidget {
  const CustomAddWidget({Key? key, required this.text, required this.onTap}) : super(key: key);
  final String text;
  final Function()?onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: ColorConstant.transparent,
      radius: 0,
      highlightColor: ColorConstant.transparent,
      focusColor: Colors.amber,
      onTap: onTap ?? (){},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(child: Icon(Icons.add),),
          context.sized.emptySizedWidthBoxLow,
          Text(text,),
        ],
      ),
    );
  }
}
