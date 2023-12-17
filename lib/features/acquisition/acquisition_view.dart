/*
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import 'package:sinavanalizi/features/acquisition/acquisition_view_model.dart';
import 'package:sinavanalizi/product/widgets/custom_dropdownmenu.dart';

import '../exam/add_exam_view.dart';

class AcquisitionView extends StatelessWidget {
  AcquisitionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.medium,
      child: Consumer<AcquisitionViewModel>(
          builder: (context, provider, _) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Soru Sayısı Seçiniz'),
                  context.sized.emptySizedHeightBoxLow,
                  CustomDropdownMenu(list: ['1', '2', '3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20'], initialSelection: '10', function: provider.changeAcquisition),
                  context.sized.emptySizedHeightBoxLow,
                  (provider.acquisition!=null) ? ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddExamView()));
                  }, child: Text('Devam Et')) : SizedBox()
                ],
              ),
            );
          },
        ),
    );
  }
}
*/
