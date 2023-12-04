import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sinavanalizi/features/login/login_view_model.dart';

class CustomDropdownMenuSchool extends StatefulWidget {
  const CustomDropdownMenuSchool({super.key, required this.list});
  final List<String> list;

  @override
  State<CustomDropdownMenuSchool> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<CustomDropdownMenuSchool> {

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
        builder: (context, provider, _) {

          return DropdownMenu<String>(
            initialSelection: provider.school != 'Okul Seçiniz' ? provider.school : widget.list.first,
            enabled: (provider.district!='İlçe Seçiniz') ? true : false,
            onSelected: (String? value) {
              // This is called when the user selects an item.
              provider.schoolChange(value!);
              print('---------');
              print(provider.district);
              print(provider.school);
            },
            dropdownMenuEntries: widget.list.map<DropdownMenuEntry<String>>((String value)
            {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          );
        }
    );
  }
}