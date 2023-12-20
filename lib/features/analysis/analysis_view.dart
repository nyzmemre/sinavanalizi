import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import 'package:sinavanalizi/features/acquisition/acquisition_view_model.dart';
import 'package:sinavanalizi/product/utilty/constants/color_constant.dart';
import 'package:sinavanalizi/product/widgets/custom_add_widget.dart';
import 'package:sinavanalizi/product/widgets/custom_textformfield.dart';
import 'package:sinavanalizi/services/read_document.dart';

class AnalysisView extends StatelessWidget {
  const AnalysisView({
    Key? key,
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
  }) : super(key: key);

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
        body: Center(
          child: Consumer2<ReadDocument, AcquisitionViewModel>(
            builder: (context, readProvider, acqProvider, _) {
              List<TextEditingController> _controllerList = List.generate(
                acqProvider.createExamSelectedAcquitionList.length*readProvider.studentNumbers.length,
                    (index) => TextEditingController(),
              );

              return SingleChildScrollView(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      // Tablo Başlıkları
                      Row(
                        children: [
                          SizedBox(
                              width: 50,
                              child: Text('No')),
                          context.sized.emptySizedWidthBoxLow,
                          SizedBox(
                              width: 100,
                              child: Text('Ad')),
                          context.sized.emptySizedWidthBoxLow,
                          SizedBox(
                              width: 100,
                              child: Text('Soyad')),
                          context.sized.emptySizedWidthBoxLow,
                          for (var i = 0;
                          i < acqProvider.createExamSelectedAcquitionList.length;
                          i++)
                            SizedBox(
                                width: 70,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 5, bottom: 2),
                                  child: Text('${i + 1}. Soru'),
                                )),
                        ],
                      ),
                      // Öğrenci Bilgileri
                      for (var i = 0; i < readProvider.studentNumbers.length; i++)
                        Row(
                          children: [
                            SizedBox(
                                width: 50,
                                child: Text(readProvider.studentNumbers[i])),
                            context.sized.emptySizedWidthBoxLow,
                            SizedBox(
                                width: 100,
                                child: Text(readProvider.studentNames[i])),
                            context.sized.emptySizedWidthBoxLow,
                            SizedBox(
                                width: 100,
                                child: Text(readProvider.studentSurnames[i])),
                            context.sized.emptySizedWidthBoxLow,
                            for (var j = 0;
                            j < acqProvider.createExamSelectedAcquitionList.length;
                            j++)
                              SizedBox(
                                width: 70,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 5, bottom: 5),
                                  child: CustomTextFormField(
                                    labelText: '',
                                    controller: _controllerList[j],
                                  ),
                                ),
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );

    /*Padding(
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
    );*/
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
