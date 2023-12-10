import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import '../utilty/constants/color_constant.dart';

class CustomAddWidget extends StatelessWidget {
  const CustomAddWidget({Key? key, required this.text, required this.widget}) : super(key: key);
  final String text;
  final Widget widget;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: ColorConstant.transparent,
      radius: 0,
      highlightColor: ColorConstant.transparent,
      focusColor: Colors.amber,
      onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));
      },
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
