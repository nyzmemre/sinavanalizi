import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import 'package:sinavanalizi/features/acquisition/acquisition_view_model.dart';
import 'package:sinavanalizi/features/analysis/analysis_view.dart';
import 'package:sinavanalizi/product/widgets/acquisition_dropdownmenu.dart';
import 'package:sinavanalizi/product/widgets/custom_dropdownmenu.dart';

import '../exam/add_exam_view.dart';

class SelectAcquisitionView extends StatelessWidget {
  SelectAcquisitionView({Key? key, required this.numberOfExam, required this.acquitionList}) : super(key: key);
  final String numberOfExam;
  final List<String> acquitionList;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: context.padding.medium,
      child: Scaffold(
        body: Consumer<AcquisitionViewModel>(
            builder: (context, provider, _) {
              //List<int> quessNumList=List.generate(int.parse(numberOfExam), (index) => index+1);
              //provider.createNumberOfQuessList(int.parse(numberOfExam));
              //List<bool> isIndexSelected=List.generate(int.parse(numberOfExam), (index) => false);
              //print(provider.numberOfQuessList);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                        itemCount: provider.numberOfQuessList.length,
                        itemBuilder: (context, int index){
                      return Column(
                        children: [
                          context.sized.emptySizedHeightBoxLow,
                          Text('${provider.numberOfQuessList[index]}. Sorunun Kazanımı'),
                          context.sized.emptySizedHeightBoxLow,
                          ///customDropdownMenu widgetında index değerini alamadığım için
                          ///kazanım seçeceğim dropdownmenü yü farklı yapmak zorunda kaldım.
                          ///bu çözüm hızlı ve basit çözümdü. AcquisitionDropDownMenu widgetını provider ile
                          ///acquisition_view_model e bağladım.
                          AcquisitionDropdownMenu(
                            hintText: (index==0 || provider.isIndexSelected[index-1]==true) ? 'Kazanım Seçiniz' : 'Aktif Değil',
                            enabled: (index==0 || provider.isIndexSelected[index-1]==true) ? true : false,
                              list: provider.selectedAcquitions, initialSelection: 'Kazanım Seçiniz', function: provider.changeAcquitionName, index: index,),
                        ],
                      );
                    }),
                    context.sized.emptySizedHeightBoxLow,
                    (provider.createExamSelectedAcquitionList.length==provider.numberOfQuessList.length) ?
                    ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AnalysisView()));
                    }, child: Text('Devam Et')) :
                    SizedBox(),
                  ],
                ),
              );/*Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Soru Numarası'),
                    context.sized.emptySizedHeightBoxLow,
                   CustomDropdownMenu(list: provider.selectedAcquitions, initialSelection: provider.selectedAcquitions.first, function: provider.changeAcquitionName),

                    context.sized.emptySizedHeightBoxLow,
                    Text(numberOfExam)
                    *//*(provider.acquisition!=null) ? ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddExamView()));
                    }, child: Text('Devam Et')) : SizedBox()*//*
                  ],
                ),
              );*/
            },
          ),
      ),
    );
  }
}
