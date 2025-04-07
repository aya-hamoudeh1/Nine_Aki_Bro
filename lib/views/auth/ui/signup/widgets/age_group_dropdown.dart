import 'package:flutter/material.dart';

class AgeGroupDropdown extends StatelessWidget {
  final String? selectedValue;
  final Function(String?) onChanged;

  const AgeGroupDropdown({
    super.key,
    required this.selectedValue,
    required this.onChanged,
  });

  static const ageGroups = [
    '13 - 17',
    '18 - 24',
    '25 - 34',
    '35 - 44',
    '45+',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Age',
        border: OutlineInputBorder(),
      ),
      value: selectedValue,
      items: ageGroups
          .map((age) => DropdownMenuItem(value: age, child: Text(age)))
          .toList(),
      onChanged: onChanged,
    );
  }
}
