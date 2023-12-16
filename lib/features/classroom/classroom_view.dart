import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import 'package:sinavanalizi/features/branch/branch_view.dart';
import 'package:sinavanalizi/features/exam/add_exam_view.dart';
import 'package:sinavanalizi/product/utilty/constants/text_constant.dart';
import 'package:sinavanalizi/services/read_document.dart';

import '../../product/utilty/constants/color_constant.dart';
import '../../product/widgets/custom_add_widget.dart';

class ClassroomView extends StatelessWidget {
  const ClassroomView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.medium,
      child: Scaffold(
        body: Consumer<ReadDocument>(
          builder: (context, provider, _) {
            if (provider.studentNames != null && provider.studentNames != []) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomAddWidget(
                      text: (provider.school.isNotEmpty)
                          ? TextConstant.addClassAgain
                          : TextConstant.addClass,
                      onTap: () async {
                        ///clearData() tekrar veri eklerken mevcut datayı silmek için kullanılıyor.
                        provider.clearData();
                        await provider.processExcelFile(context);
                      },
                    ),
                    context.sized.emptySizedHeightBoxLow,
                    if (provider.studentNumbers.isNotEmpty)
                      Text(
                        'Bilgiler doğruysa alttaki KAYDET butonuna tıklayınız.',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: ColorConstant.appRed),
                      ),
                    context.sized.emptySizedHeightBoxLow,
                    if (provider.city.isNotEmpty) Text('İl: ${provider.city}'),
                    if (provider.district.isNotEmpty)
                      Text('İlçe: ${provider.district}'),
                    if (provider.school.isNotEmpty)
                      Text('Okul: ${provider.school}'),
                    if (provider.className.isNotEmpty)
                      Text('Sınıf: ${provider.className}'),
                    if (provider.studentNumbers.isNotEmpty)
                      Text('Öğrenci Bilgileri'),
                    context.sized.emptySizedHeightBoxLow,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (provider.studentNumbers.isNotEmpty)
                          customListview('No', provider.studentNumbers),
                        context.sized.emptySizedWidthBoxLow,
                        if (provider.studentNames.isNotEmpty)
                          customListview('Ad', provider.studentNames),
                        context.sized.emptySizedWidthBoxLow,
                        if (provider.studentSurnames.isNotEmpty)
                          customListview('Soyad', provider.studentSurnames),
                      ],
                    ),
                    context.sized.emptySizedHeightBoxLow,
                    (provider.school.isNotEmpty)
                        ? ElevatedButton(
                            onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddExamView()));
                            }, child: Text('Devam Et'))
                        : SizedBox(),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget customListview(String title, List<String> list) {
    return Column(
      children: [
        Text(title),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: list.map((e) => Text(e)).toList(),
        )
      ],
    );
  }
}
