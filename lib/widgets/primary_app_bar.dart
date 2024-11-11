import 'package:flutter/material.dart';
import 'package:tractian/widgets/app_bar.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PrimaryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TractianAppBar(
      titleImage: Image.asset(
        'assets/images/tractian.png',
        height: 24,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48);
}
