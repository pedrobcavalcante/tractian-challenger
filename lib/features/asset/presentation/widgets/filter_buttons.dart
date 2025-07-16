import 'package:flutter/material.dart';

import 'filter_button.dart';

class FilterButtons extends StatelessWidget {
  final ValueChanged<bool> onEnergyFilterSelected;
  final ValueChanged<bool> onCriticalFilterSelected;
  final ValueChanged<bool> onOperationalFilterSelected;
  final bool isEnergySelected;
  final bool isCriticalSelected;
  final bool isOperationalSelected;

  const FilterButtons({
    super.key,
    required this.onEnergyFilterSelected,
    required this.onCriticalFilterSelected,
    required this.onOperationalFilterSelected,
    required this.isEnergySelected,
    required this.isCriticalSelected,
    required this.isOperationalSelected,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SelectableButton(
            text: 'Sensor de Energia',
            iconPath: 'assets/icons/bolt.svg',
            isSelected: isEnergySelected,
            onSelectionChanged: onEnergyFilterSelected,
          ),
          const SizedBox(width: 8),
          SelectableButton(
            text: 'Crítico',
            iconPath: 'assets/icons/error_outline.svg',
            isSelected: isCriticalSelected,
            onSelectionChanged: onCriticalFilterSelected,
          ),
          const SizedBox(width: 8),
          SelectableButton(
            text: 'Operacional (Extra)',
            iconPath: 'assets/icons/bolt.svg',
            isSelected: isOperationalSelected,
            onSelectionChanged: onOperationalFilterSelected,
          ),
        ],
      ),
    );
  }
}
