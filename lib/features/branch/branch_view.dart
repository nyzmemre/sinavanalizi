/*
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import 'package:sinavanalizi/features/acquisition/select_acquisition_view.dart';
import 'package:sinavanalizi/features/branch/branch_view_model.dart';
import 'package:sinavanalizi/product/widgets/custom_dropdownmenu.dart';

class BranchView extends StatelessWidget {
  BranchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.medium,
      child:Consumer<BranchViewModel>(
          builder: (context, provider, _) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Branş Seçiniz'),
                  context.sized.emptySizedHeightBoxLow,
                 CustomDropdownMenu(list: ['Branş Seçiniz','Matematik', 'Türkçe', 'İngilizce'], initialSelection: 'Branş Seçiniz', function: provider.changeBranch),
                  context.sized.emptySizedHeightBoxLow,
                  Text('Soru Sayısı Seçiniz'),
                  context.sized.emptySizedHeightBoxLow,
                  (provider.branch!=null && provider.branch!='Branş Seçiniz') ? ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AcquisitionView()));
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
