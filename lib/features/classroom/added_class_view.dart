import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sinavanalizi/services/read_document.dart';

class AddedClassView extends StatelessWidget {
  const AddedClassView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Consumer<ReadDocument>(
          builder: (context, provider, _) {
            print(provider.studentSurnames.length);
            print(provider.studentCount);
            if(provider.studentCount != -1) {
              return Center(
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    children: [
                      Text('İl: ${provider.city}'),
                      Text('İlçe: ${provider.district}'),
                      Text('Okul: ${provider.school}'),
                      Text('Sınıf: ${provider.className}'),
                      Text('Öğrenci sayısı: ${provider.studentCount}'),
                      Text('Öğrenci sayısı: ${provider.studentNames.first}'),
                      Row(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: provider.studentNumbers.length,
                              itemBuilder: (context, int index) {
                                return Text(provider.studentNumbers[index]);
                              },
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: provider.studentNames.length,
                              itemBuilder: (context, int index) => Text(provider.studentNames[index]),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: provider.studentSurnames.length,
                              itemBuilder: (context, int index) => Text(provider.studentSurnames[index]),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(child: Text('Sınıf bilgileri yüklenemedi. Lütfen tekrar deneyiniz!'),);
            }
          }
      ),
    );

  }
}
