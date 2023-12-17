import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sinavanalizi/features/login/login_view_model.dart';

class CustomDropdownMenu extends StatefulWidget {
  const CustomDropdownMenu({super.key, required this.list, required this.initialSelection, required this.function, this.enabled, this.hintText});
  final List<String> list;
  final String initialSelection;
  final Function(String) function;
  final bool? enabled;
  final String? hintText;


  @override
  State<CustomDropdownMenu> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<CustomDropdownMenu> {

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: widget.initialSelection,
      hintText: widget.hintText,
      enabled: widget.enabled ?? true,
      onSelected:(String? value) {
        // This is called when the user selects an item.
        widget.function(value!);
      },
      dropdownMenuEntries: widget.list.map<DropdownMenuEntry<String>>((String value)
      {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}