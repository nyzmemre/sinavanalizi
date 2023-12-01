import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sinavanalizi/features/login/login_view_model.dart';

class CustomDropdownMenu extends StatefulWidget {
  const CustomDropdownMenu({super.key, required this.list});
  final List<String> list;

  @override
  State<CustomDropdownMenu> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<CustomDropdownMenu> {

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (context, provider, _) {
        return DropdownMenu<String>(
          initialSelection: widget.list.first,
          onSelected:(String? value) {
            // This is called when the user selects an item.

            setState(() {
              if(widget.list.first=='İl Seçiniz'){
                provider.cityChange(value!);
                print('İl');
                print('city: ${provider.city}');
                print('district: ${provider.district}');

              } else {
                provider.districtChange(value!);
                print('ilçe');
                print('city: ${provider.city}');
                print('district: ${provider.district}');
              }
            });
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