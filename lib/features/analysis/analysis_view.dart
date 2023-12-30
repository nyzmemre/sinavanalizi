import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:sinavanalizi/features/acquisition/acquisition_view_model.dart';
import 'package:sinavanalizi/features/analysis/analysis_view_model.dart';
import 'package:sinavanalizi/product/utilty/constants/color_constant.dart';
import 'package:sinavanalizi/product/widgets/custom_add_widget.dart';
import 'package:sinavanalizi/product/widgets/custom_textformfield.dart';
import 'package:sinavanalizi/services/read_document.dart';

class AnalysisView extends StatefulWidget {
  @override
  State<AnalysisView> createState() => _AnalysisViewState();
}

class _AnalysisViewState extends State<AnalysisView> {
  GlobalKey _key = GlobalKey<FormState>();

  List<TextEditingController> _controllerList = [];
  List<FocusNode> _focusNodeList = [];
  List<int> _totalPoints = [];
  List<int> _acqPoints=[];

  @override
  void initState() {
    super.initState();

    // Provider ile ilişkilendirilmiş olan veriyi alın
    var acqProvider = Provider.of<AcquisitionViewModel>(context, listen: false);
    var readProvider = Provider.of<ReadDocument>(context, listen: false);

    _totalPoints = List.generate(readProvider.studentNumbers.length, (index) => 0);

    _focusNodeList = List.generate(
      acqProvider.createExamSelectedAcquitionList.length * readProvider.studentNumbers.length,
          (index) => FocusNode(),
    );

    // _controllerList'i oluşturun
    _controllerList = List.generate(
      acqProvider.createExamSelectedAcquitionList.length * readProvider.studentNumbers.length,
          (index) => TextEditingController(),
    );

    _acqPoints=List.generate(acqProvider.createExamSelectedAcquitionList.length, (index) => 999);

    _focusNodeList.asMap().forEach((index, focusNode) {
      focusNode.addListener(() {
        for (var i = 0; i < readProvider.studentNumbers.length; i++) {
          _totalPoints.insert(i, 0);
          for (var j = 0; j < acqProvider.createExamSelectedAcquitionList.length; j++) {
            int total = 0;
            String val = '';

            for (var k = 0; k < acqProvider.createExamSelectedAcquitionList.length; k++) {
              val = _controllerList[i * acqProvider.createExamSelectedAcquitionList.length + k].text;
              int score = int.tryParse(val) ?? 0;
              total += score;
           //   _acqPoints.insert(k, score);

            }
            _totalPoints.insert(i, total);

/*print('i * acqProvider.createExamSelectedAcquitionList.length + j');
print(i * acqProvider.createExamSelectedAcquitionList.length + acqProvider.createExamSelectedAcquitionList.length*j);
print('i: $i');*/
          }
        }
      });
    });
  }



  @override
  void dispose() {
    // _controllerList ve _focusNodeList içindeki her bir elemanı temizle
    _controllerList.forEach((controller) => controller.dispose());
    _focusNodeList.forEach((focusNode) => focusNode.dispose());

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.medium,
      child: Scaffold(
        body: Form(
          key: _key,
          child: Center(
            child: Consumer2<ReadDocument, AcquisitionViewModel>(
              builder: (context, readProvider, acqProvider, _) {
                return SingleChildScrollView(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 50, child: Text('No')),
                            context.sized.emptySizedWidthBoxLow,
                            SizedBox(width: 100, child: Text('Ad')),
                            context.sized.emptySizedWidthBoxLow,
                            SizedBox(width: 100, child: Text('Soyad')),
                            context.sized.emptySizedWidthBoxLow,
                            for (var i = 0; i < acqProvider.createExamSelectedAcquitionList.length; i++)
                              SizedBox(
                                width: 70,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 5, bottom: 2),
                                  child: Text('${i + 1}. Soru'),
                                ),
                              ),
                            SizedBox(width: 100, child: Text('Puan')),
                          ],
                        ),
                        for (var i = 0; i < readProvider.studentNumbers.length; i++)
                          Row(
                            children: [
                              SizedBox(width: 50, child: Text(readProvider.studentNumbers[i])),
                              context.sized.emptySizedWidthBoxLow,
                              SizedBox(width: 100, child: Text(readProvider.studentNames[i])),
                              context.sized.emptySizedWidthBoxLow,
                              SizedBox(width: 100, child: Text(readProvider.studentSurnames[i])),
                              context.sized.emptySizedWidthBoxLow,
                              for (var j = 0; j < acqProvider.createExamSelectedAcquitionList.length; j++)
                                SizedBox(
                                  width: 70,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 5, bottom: 5),
                                    child: CustomTextFormField(
                                      focusNode: _focusNodeList[i * acqProvider.createExamSelectedAcquitionList.length + j],
                                      onChanged: (value) {
                                        // Değerin bir sayıya dönüştürülebilir olup olmadığını kontrol et
                                        final intVal = int.tryParse(value.replaceAll(',', '.'));

                                        // 0 ile 100 arasında olup olmadığını kontrol et
                                        if (intVal == null || intVal < 0 || intVal > 100) {
                                          _controllerList[i * acqProvider.createExamSelectedAcquitionList.length + j].text = '0';

                                          MotionToast.error(
                                            position: MotionToastPosition.center,
                                            description: Text('Puan Değerini Yanlış Aralıkta Girdiniz!'),
                                          ).show(context);
                                          return; // Hatalı durumda işlemi sonlandır
                                        }

                                        // Toplam puanları güncelle
                                        int total = 0;
                                        for (var k = 0; k < acqProvider.createExamSelectedAcquitionList.length; k++) {
                                          total += int.tryParse(_controllerList[i * acqProvider.createExamSelectedAcquitionList.length + k].text) ?? 0;
                                        }

                                        // 100 üzerindeyse son girilen değeri 0 yap ve hata mesajı göster
                                        if (total > 100) {
                                          _controllerList[i * acqProvider.createExamSelectedAcquitionList.length + j].text = '0';
                                          MotionToast.error(
                                            position: MotionToastPosition.center,
                                            description: Text('Toplam Puan 100 üzerinde olamaz!'),
                                          ).show(context);
                                          return;
                                        }

                                        _totalPoints[i] = total;
                                        setState(() {});
                                      },
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
                                        TextInputFormatter.withFunction(
                                              (oldValue, newValue) => newValue.copyWith(
                                            text: newValue.text.replaceAll('.', ','),
                                          ),
                                        ),
                                      ],
                                      keyboardType: TextInputType.number,
                                      labelText: '',
                                      controller: _controllerList[i * acqProvider.createExamSelectedAcquitionList.length + j],
                                    ),
                                  ),
                                ),
                              context.sized.emptySizedWidthBoxLow,
                              SizedBox(width: 100, child: Text(_totalPoints[i].toString())),
                            ],
                          ),
                        Row(
                          children: [
                            SizedBox(width: 50, child: Text(' ')),
                            context.sized.emptySizedWidthBoxLow,
                            SizedBox(width: 100, child: Text(' ')),
                            context.sized.emptySizedWidthBoxLow,
                            SizedBox(width: 100, child: Text(' ')),
                            context.sized.emptySizedWidthBoxLow,

                            for (var e = 0; e < acqProvider.createExamSelectedAcquitionList.length; e++)
                              SizedBox(
                                width: 70,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 5, bottom: 2),
                                  child: Text('${(calculateColumnAverage(e, readProvider.studentNumbers.length)).toStringAsFixed(2)}',
                                    style: TextStyle(fontWeight: FontWeight.bold,),
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
      ),
    );
  }
  double calculateColumnAverage(int columnIndex, int rowCount) {
    int total = 0;
    int validRowCount = 0;

    for (var i = 0; i < rowCount; i++) {
      String value = _controllerList[i * _acqPoints.length + columnIndex].text;
      if (value.isNotEmpty) {
        total += int.tryParse(value) ?? 0;
        validRowCount++;
      }
    }

    return validRowCount > 0 ? total / validRowCount : 0;
  }
}
