import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sinavanalizi/features/branch/branch_view_model.dart';
import 'package:provider/provider.dart';

import '../../product/widgets/custom_dropdownmenu.dart';
import '../acquisition/acquisition_view_model.dart';

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
                        list: ['Branş Seçiniz', 'Matematik', 'Türkçe', 'İngilizce'],
                        initialSelection: 'Branş Seçiniz',
                        function: provider.changeBranch,
                      );
                    },
                  ),
                ),
                context.sized.emptySizedHeightBoxLow,
                Text('Soru Sayısı Seçiniz'),
                context.sized.emptySizedHeightBoxLow,
                SizedBox(
                  height: 50,
                  child: Consumer<AcquisitionViewModel>(
                    builder: (context, provider, _) {
                      return CustomDropdownMenu(
                        list: const [
                          '1', '2', '3', '4', '5', '6', '7', '8', '9', '10',
                          '11', '12', '13', '14', '15', '16', '17', '18', '19', '20'
                        ],
                        initialSelection: '10',
                        function: provider.changeAcquisition,
                      );
                    },
                  ),
                ),

                // Buraya `Expanded` widget'ını ekleyebilirsiniz.

              ],
            ),
          ),
        ),
      ),
    );
  }
}
