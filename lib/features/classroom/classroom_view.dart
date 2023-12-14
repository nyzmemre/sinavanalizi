import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import 'package:sinavanalizi/product/utilty/constants/text_constant.dart';
import 'package:sinavanalizi/services/read_document.dart';

import '../../product/utilty/constants/color_constant.dart';
import '../../product/widgets/custom_add_widget.dart';

class ClassroomView extends StatelessWidget {
  const ClassroomView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ReadDocument>(
        builder: (context, provider, _) {
          if (provider.studentNames != null && provider.studentNames!=[]) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomAddWidget(
                    text: TextConstant.addClass,
                    onTap: () async {
                      ///clearData() tekrar veri eklerken mevcut datayı silmek için kullanılıyor.
                      provider.clearData();
                      await provider.processExcelFile(context);
                    },
                  ),
              if (provider.studentNumbers.isNotEmpty) Text('Bilgileri Kontrol Ediniz'),
              if (provider.city.isNotEmpty) Text('İl: ${provider.city}'),
              if (provider.district.isNotEmpty) Text('İlçe: ${provider.district}'),
              if (provider.school.isNotEmpty) Text('Okul: ${provider.school}'),
              if (provider.className.isNotEmpty) Text('Sınıf: ${provider.className}'),
              if (provider.studentNumbers.isNotEmpty) Text('Öğrenci Bilgileri'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (provider.studentNumbers.isNotEmpty) customListview('No', provider.studentNumbers),
                  context.sized.emptySizedWidthBoxLow,
                  if (provider.studentNames.isNotEmpty) customListview('Ad', provider.studentNames),
                  context.sized.emptySizedWidthBoxLow,
                  if (provider.studentSurnames.isNotEmpty) customListview('Soyad', provider.studentSurnames),
                ],
              )
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget customListview(String title, List<String> list) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
