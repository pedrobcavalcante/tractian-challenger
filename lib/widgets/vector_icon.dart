import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VectorIcon extends StatelessWidget {
  const VectorIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/vector.svg',
      width: 21.11,
      height: 16.29,
      colorFilter: const ColorFilter.mode(
        Colors.white,
        BlendMode.srcIn,
      ),
    );
  }
}
