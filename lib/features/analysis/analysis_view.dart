import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sinavanalizi/product/utilty/constants/color_constant.dart';

class AnalysisView extends StatelessWidget {
  const AnalysisView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.medium,
      child: Scaffold(
        body: Column(
          children: [
            InkWell(
              hoverColor: ColorConstant.transparent,
              radius: 0,
              highlightColor: ColorConstant.transparent,
              focusColor: Colors.amber,
              onTap: (){
                
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(child: Icon(Icons.add),),
                  context.sized.emptySizedWidthBoxLow,
                  Text('Analiz Ekle',),
                ],
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, int index){
              return InkWell(
                onTap: (){},
                child: ListTile(
                  title: Text('7/A Türkçe'),
                ),
              );
            }),
          ],
        )
      ),
    );
  }
}
