import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sinavanalizi/features/login/login_view_model.dart';

class CustomDropdownMenuCity extends StatefulWidget {
  const CustomDropdownMenuCity({super.key, required this.list});
  final List<String> list;

  @override
  State<CustomDropdownMenuCity> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<CustomDropdownMenuCity> {

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (context, provider, _) {
        return DropdownMenu<String>(
          initialSelection: widget.list.first,
          onSelected:(String? value) {
            // This is called when the user selects an item.
      provider.cityChange(value!);
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