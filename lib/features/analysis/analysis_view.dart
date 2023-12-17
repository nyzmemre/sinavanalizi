import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sinavanalizi/product/utilty/constants/color_constant.dart';
import 'package:sinavanalizi/product/widgets/custom_add_widget.dart';

class AnalysisView extends StatelessWidget {
  const AnalysisView(
      {Key? key,
    // required this.city,
    // required this.district,
    // required this.schoolName,
    // required this.className,
    // required this.branch,
    // required this.teacherName,
    // required this.teacherSurname,
    // required this.examNum,
    // required this.periodNum,
    // required this.numberOfQuess,
    // required this.quessPoint,
    // required this.acquisition,
    // required this.acquisitionPoint,
    // required this.studentNum,
    // required this.studentName,
    // required this.studentSurname
      })
      : super(key: key);
 // final String city;
 // final String district;
 // final String schoolName;
 // final String className;
 // final String branch;
 // final String teacherName;
 // final String teacherSurname;
 // final String examNum;
 // final String periodNum;
 // final int numberOfQuess;
 // final List<int> quessPoint;
 // final List<String> acquisition;
 // final List<int> acquisitionPoint;
 // final List<String> studentNum;
 // final List<String> studentName;
 // final List<String> studentSurname;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.medium,
      child: Scaffold(
          body: Column(
        children: [
          CustomAddWidget(text: 'Analiz Ekle', onTap: () {}),
          ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, int index) {
                return InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: Text('7/A Türkçe'),
                  ),
                );
              }),
        ],
      )),
    );
  }
}
/*
@override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.medium,
      child: Scaffold(
        body: Column(
          children: [
            CustomAddWidget(text: 'Analiz Ekle', onTap: (){}),
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
*/
