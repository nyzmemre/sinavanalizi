import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:kartal/kartal.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:provider/provider.dart';
import 'package:sinavanalizi/features/acquisition/acquisition_view_model.dart';
import 'package:sinavanalizi/features/analysis/analysis_view_model.dart';
import 'package:sinavanalizi/product/utilty/constants/color_constant.dart';
import 'package:sinavanalizi/product/widgets/custom_add_widget.dart';
import 'package:sinavanalizi/product/widgets/custom_textformfield.dart';
import 'package:sinavanalizi/services/read_document.dart';

class AnalysisView extends StatefulWidget {
  AnalysisView({
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

  @override
  State<AnalysisView> createState() => _AnalysisViewState();
}

class _AnalysisViewState extends State<AnalysisView> {
  // final String city;
  GlobalKey _key=GlobalKey<FormState>();

  List<TextEditingController> _controllerList = [];
  List<FocusNode> _focusNodeList=[];
  List<int> _totalPoints = [];

  @override
  void initState() {
    super.initState();

    // Provider ile ilişkilendirilmiş olan veriyi alın
    var acqProvider = Provider.of<AcquisitionViewModel>(context, listen: false);
    var readProvider = Provider.of<ReadDocument>(context, listen: false);

    _totalPoints = List.generate(
        readProvider.studentNumbers.length, (index) => 0);



    _focusNodeList = List.generate(
        acqProvider.createExamSelectedAcquitionList.length *
            readProvider.studentNumbers.length, (index) => FocusNode());

    // _controllerList'i oluşturun
    _controllerList = List.generate(
      acqProvider.createExamSelectedAcquitionList.length *
          readProvider.studentNumbers.length,
          (index) => TextEditingController(),
    );

    // Burada _controllerList'i kullanabilirsiniz


    _focusNodeList.asMap().forEach((index, focusNode) {
      focusNode.addListener(() {

            print('$index: ${_controllerList[index].text}');

            for (var i = 0; i < readProvider.studentNumbers.length; i++) {
              _totalPoints.add(0);
              for (var j = 0; j < acqProvider.createExamSelectedAcquitionList.length; j++) {
                _focusNodeList.add(FocusNode());
              }}

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
            child: Consumer3<ReadDocument, AcquisitionViewModel, AnalysisViewModel>(
              builder: (context, readProvider, acqProvider, analysisProvider, _) {
                /*List<TextEditingController> _controllerList = List.generate(
                  acqProvider.createExamSelectedAcquitionList.length*readProvider.studentNumbers.length,
                      (index) => TextEditingController(),
                );*/

               // List<TextEditingController> _resultController=List.generate(acqProvider.createExamSelectedAcquitionList.length*readProvider.studentNumbers.length, (index) => TextEditingController());
               // List<FocusNode> _focusNodeList=List.generate(acqProvider.createExamSelectedAcquitionList.length*readProvider.studentNumbers.length, (index) => FocusNode());
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
                            SizedBox(
                                width: 100,
                                child: Text('Puan'))
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
                                    child: /*TextField(


                                      onChanged: (value) {
                                        final intVal = int.tryParse(value.replaceAll(',', '.'));
                                        if (intVal != null && (intVal > 100 || intVal < 0)) {
                                          // Değer 0 ile 100 arasında değilse uygun bir geribildirimde bulunabilirsiniz.
                                          // Örneğin, bir snackbar gösterme, bir ikon değiştirme, bir renk değiştirme vb.
                                          MotionToast.error(
                                              position: MotionToastPosition.center,
                                              description: Text('Puan Değerini Yanlış Aralıkta Girdiniz!')).show(context);
                                        }



                                      },

                                      onSubmitted: (String value){

                                        analysisProvider.counter(int.parse(value));
                                        print(analysisProvider.a);


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
                                      controller: _controllerList[
                                      i * acqProvider.createExamSelectedAcquitionList.length +
                                          j],
                                    ),
*/

                                    CustomTextFormField(
                                      focusNode: _focusNodeList[i*acqProvider.createExamSelectedAcquitionList.length+j],
                                      onFieldSubmitted: (String value) {
                                        // Bu kısım, Enter tuşuna basıldığında çalışacaktır
                                        analysisProvider.counter(int.parse(value));
                                        print(analysisProvider.a);

                                        // Toplam puanları güncelle

                                      },

                                      onChanged: (value) {
                                        final intVal = int.tryParse(value.replaceAll(',', '.'));
                                        if (intVal != null && (intVal > 100 || intVal < 0)) {
                                          // Değer 0 ile 100 arasında değilse uygun bir geribildirimde bulunabilirsiniz.
                                          // Örneğin, bir snackbar gösterme, bir ikon değiştirme, bir renk değiştirme vb.
                                          MotionToast.error(
                                              position: MotionToastPosition.center,
                                              description: Text('Puan Değerini Yanlış Aralıkta Girdiniz!')).show(context);
                                        }

                                        int total = 0;
                                        for (var k = 0; k < acqProvider.createExamSelectedAcquitionList.length; k++) {
                                          total += int.parse(_controllerList[i * acqProvider.createExamSelectedAcquitionList.length + k].text);
                                        }
                                        _totalPoints[i] = total;

                                        // UI'yi güncelle
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
                                      controller: _controllerList[
                                      i * acqProvider.createExamSelectedAcquitionList.length +
                                          j],
                                    ),
                                  ),
                                ),
                              context.sized.emptySizedWidthBoxLow,
                              SizedBox(
                                  width: 100,
                                child: Text(_totalPoints[i].toString()),
                              )


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
}
