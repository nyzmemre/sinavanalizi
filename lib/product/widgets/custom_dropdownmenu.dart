import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatefulWidget {
  const CustomDropdownMenu({super.key, required this.list});
  final List<String> list;
  @override
  State<CustomDropdownMenu> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<CustomDropdownMenu> {

  @override
  Widget build(BuildContext context) {
    var dropdownValue = widget.list.first;

    return DropdownMenu<String>(
      initialSelection: widget.list.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: widget.list.map<DropdownMenuEntry<String>>((String value)
      {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}