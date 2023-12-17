import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sinavanalizi/features/acquisition/select_acquisition_view.dart';
import 'package:sinavanalizi/features/branch/branch_view_model.dart';
import 'package:provider/provider.dart';
import 'package:sinavanalizi/services/read_document.dart';

import '../../product/widgets/custom_dropdownmenu.dart';
import '../acquisition/acquisition_view_model.dart';
import 'exam_view_model.dart';

class AddExamView extends StatelessWidget {
  const AddExamView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.medium,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                context.sized.emptySizedHeightBoxLow,
                Text('Branş Seçiniz'),
                context.sized.emptySizedHeightBoxLow,
                SizedBox(
                  height: 50,
                  child: Consumer<BranchViewModel>(
                    builder: (context, provider, _) {
                      return CustomDropdownMenu(
                        list: ['Matematik', 'Türkçe', 'İngilizce'],
                        initialSelection: 'Branş Seçiniz',
                        hintText: 'Branş Seçiniz',
                        function: provider.changeBranch,
                      );
                    },
                  ),
                ),

                context.sized.emptySizedHeightBoxLow,
                Text('Sınıf Seviyesi Seçiniz'),
                context.sized.emptySizedHeightBoxLow,
                SizedBox(
                  height: 50,
                  child: Consumer<ExamViewModel>(
                    builder: (context, provider, _) {
                      return CustomDropdownMenu(
                        list: ['1. Sınıf', '2. Sınıf', '3. Sınıf', '4. Sınıf', '5. Sınıf', '6. Sınıf', '7. Sınıf', '8. Sınıf', '9. Sınıf', '10. Sınıf',
                          '11. Sınıf', '12. Sınıf',],
                        initialSelection: '1. Sınıf',
                        function: provider.changeClassGrade,
                      );
                    },
                  ),
                ),
                context.sized.emptySizedHeightBoxLow,
                Text('Soru Sayısı Seçiniz'),
                context.sized.emptySizedHeightBoxLow,
                SizedBox(
                  height: 50,
                  child: Consumer<ExamViewModel>(
                    builder: (context, provider, _) {
                      return CustomDropdownMenu(
                        list: const [
                          '1', '2', '3', '4', '5', '6', '7', '8', '9', '10',
                          '11', '12', '13', '14', '15', '16', '17', '18', '19', '20'
                        ],
                        initialSelection: provider.numberOfQuess,
                        function: provider.changeNumberOfQuess,
                      );
                    },
                  ),
                ),
/*context.sized.emptySizedHeightBoxLow,
                Text('Dönem Seçiniz'),
                context.sized.emptySizedHeightBoxLow,
                SizedBox(
                  height: 50,
                  child: Consumer<ExamViewModel>(
                    builder: (context, provider, _) {
                      return CustomDropdownMenu(
                        list: const [
                          '1', '2'
                        ],
                        initialSelection: provider.periodNum,
                        function: provider.changePeriodNum,
                      );
                    },
                  ),
                ),*/

                context.sized.emptySizedHeightBoxLow,

                Consumer3<AcquisitionViewModel,BranchViewModel, ExamViewModel>(
                  builder: (context, providerAcquisition, providerBranch, providerEXAM, _) {
                    return ElevatedButton(onPressed: (){
                      providerAcquisition.getAcquisitionNameList(providerBranch.branch, providerEXAM.classGrade.split('.').first);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectAcquisitionView(numberOfExam: providerEXAM.numberOfQuess, acquitionList: providerAcquisition.selectedAcquitions)));
                      ///soru sayısı kadar liste uzunluğu ve seçimi false olan liste oluşturuyorum sonraki sayfa için.
                      providerAcquisition.createNumberOfQuessList(int.parse(providerEXAM.numberOfQuess));

                     // print(providerAcquisition.selectedAcquitions);
                     // print(Provider.of<ReadDocument>(context, listen: false).studentNames);
                    }, child: Text('Devam Et'));
                  },
                )
                // Buraya `Expanded` widget'ını ekleyebilirsiniz.

              ],
            ),
          ),
        ),
      ),
    );
  }
  void selectPeriodNum(String val) {

  }
}
