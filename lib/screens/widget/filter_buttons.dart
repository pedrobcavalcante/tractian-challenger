import 'package:flutter/material.dart';
import 'package:tractian/screens/widget/filter_button.dart';

class FilterButtons extends StatelessWidget {
  const FilterButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SelectableButton(
            text: 'Sensor de Energia',
            iconPath: 'assets/icons/bolt.svg',
            isSelected: false,
            onPressed: () {},
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SelectableButton(
            text: 'Crítico',
            iconPath: 'assets/icons/error_outline.svg',
            isSelected: false,
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
