import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:sinavanalizi/services/read_document.dart';
import '../../features/classroom/added_class_view.dart';
import '../utilty/constants/color_constant.dart';

class CustomAddWidget extends StatelessWidget {
  const CustomAddWidget({Key? key, required this.text}) : super(key: key);
  final String text;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: ColorConstant.transparent,
      radius: 0,
      highlightColor: ColorConstant.transparent,
      focusColor: Colors.amber,
      onTap: ()async{

          await ReadDocument().processExcelFile(context);
         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddedClassView()));

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
