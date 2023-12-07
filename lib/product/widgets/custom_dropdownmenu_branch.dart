import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sinavanalizi/features/login/login_view_model.dart';

class CustomDropdownMenuBranch extends StatefulWidget {
  const CustomDropdownMenuBranch({super.key, required this.list});
  final List<String> list;



  @override
  State<CustomDropdownMenuBranch> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<CustomDropdownMenuBranch> {

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
        builder: (context, provider, _) {
          return DropdownMenu<String>(
            initialSelection: provider.branch != 'Branş Seçiniz' ? provider.branch : widget.list.first,
            onSelected:(String? value) {
              // This is called when the user selects an item.
              provider.branchChange(value!);
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