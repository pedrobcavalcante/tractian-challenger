import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectableButton extends StatefulWidget {
  final String text;
  final String iconPath;
  final VoidCallback? onPressed;
  final bool isSelected;

  const SelectableButton({
    super.key,
    required this.text,
    required this.iconPath,
    this.onPressed,
    this.isSelected = false,
  });

  @override
  SelectableButtonState createState() => SelectableButtonState();
}

class SelectableButtonState extends State<SelectableButton> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  void _toggleSelection() {
    setState(() {
      _isSelected = !_isSelected;
    });
    if (widget.onPressed != null) {
      widget.onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSelection,
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: _isSelected ? const Color(0xFF2188FF) : Colors.transparent,
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
                _isSelected ? Colors.white : const Color(0xFF77818C),
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
                color: _isSelected ? Colors.white : const Color(0xFF77818C),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
