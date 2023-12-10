import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sinavanalizi/services/read_document.dart';
import 'package:sinavanalizi/services/upload_file.dart';
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
      onTap: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(text),
          content: ElevatedButton(onPressed: ()async{
            await ReadDocument().processExcelFile();
          }, child: Text('Dosyayı Yükle')),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
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
