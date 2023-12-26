import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sinavanalizi/features/acquisition/acquisition_view_model.dart';
import 'package:sinavanalizi/features/login/login_view_model.dart';

class AcquisitionDropdownMenu extends StatefulWidget {
  const AcquisitionDropdownMenu({super.key, required this.list, required this.initialSelection, required this.function, required this.index, this.enabled, this.hintText});

  final List<String> list;
  final String initialSelection;
  final Function(String) function;
  final bool? enabled;
  final int index;
  final String? hintText;

  @override
  State<AcquisitionDropdownMenu> createState() => _AcquisitionDropdownMenu();
}

class _AcquisitionDropdownMenu extends State<AcquisitionDropdownMenu> {

  @override
  Widget build(BuildContext context) {
    return Consumer<AcquisitionViewModel>(
      builder: (context, provider,_) {
        return DropdownMenu<String>(
          hintText: widget.hintText,
          initialSelection: widget.initialSelection,
          enabled: widget.enabled ?? true,
          onSelected:(String? value) {
            // This is called when the user selects an item.
            widget.function(value!);
            ///değer seçimi yapıldığında isIndexSelected true oluyor.
            ///bu sayede select_acquisition_view sayfasında kazanım seçilen sorudan sonraki
            ///dropdownmenü aktif oluyor.
            provider.isIndexSelected[widget.index]= true;

            ///3. kazanımın seçilebilmesi için 2. kazanımın girilmesi lazım.
            ///2. kazanım girildikten sonra 3. kazanımı seçtik. sonra 2. kazanımı değiştirmek istedik.
            ///o zaman sadece 2. kazanımın değişmesi gerekir. listeye yeni item eklenmemeli.
            ///bunu sağlamak için listenin uzunluğu<=index durumunu kontrol ediyorum.
            (provider.createExamSelectedAcquitionList.length<=widget.index) ? provider.createExamSelectedAcquitionList.insert(widget.index, value) :
            provider.createExamSelectedAcquitionList[widget.index]=value;
            print(provider.isIndexSelected);
            print(provider.createExamSelectedAcquitionList);
          },
          dropdownMenuEntries: widget.list.map<DropdownMenuEntry<String>>((String value)
          {
            return DropdownMenuEntry<String>(value: value, label: value);
          }).toList(),
        );
      },
    );
  }
}