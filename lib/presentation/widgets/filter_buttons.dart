import 'package:flutter/material.dart';

import 'filter_button.dart';

class FilterButtons extends StatelessWidget {
  final ValueChanged<bool> onEnergyFilterSelected;
  final ValueChanged<bool> onCriticalFilterSelected;

  const FilterButtons({
    super.key,
    required this.onEnergyFilterSelected,
    required this.onCriticalFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SelectableButton(
          text: 'Sensor de Energia',
          iconPath: 'assets/icons/bolt.svg',
          onSelectionChanged: onEnergyFilterSelected,
        ),
        const SizedBox(width: 8),
        SelectableButton(
          text: 'Crítico',
          iconPath: 'assets/icons/error_outline.svg',
          onSelectionChanged: onCriticalFilterSelected,
        ),
      ],
    );
  }
}
