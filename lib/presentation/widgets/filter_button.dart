import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectableButton extends StatefulWidget {
  final String text;
  final String iconPath;
  final ValueChanged<bool> onSelectionChanged;

  const SelectableButton({
    super.key,
    required this.text,
    required this.iconPath,
    required this.onSelectionChanged,
  });

  @override
  _SelectableButtonState createState() => _SelectableButtonState();
}

class _SelectableButtonState extends State<SelectableButton> {
  bool isSelected = false;

  void _toggleSelection() {
    setState(() {
      isSelected = !isSelected;
    });

    widget.onSelectionChanged(isSelected);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSelection,
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2188FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(
            color: const Color(0xFFD8DFE6),
            width: 1,
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              widget.iconPath,
              colorFilter: ColorFilter.mode(
                isSelected ? Colors.white : const Color(0xFF77818C),
                BlendMode.srcIn,
              ),
              width: 16,
              height: 16,
            ),
            const SizedBox(width: 8),
            Text(
              widget.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : const Color(0xFF77818C),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
