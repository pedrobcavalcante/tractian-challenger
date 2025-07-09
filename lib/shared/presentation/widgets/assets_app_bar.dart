import 'package:flutter/material.dart';
import 'package:tractian/shared/presentation/widgets/app_bar.dart';

class AssetsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AssetsAppBar({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TractianAppBar(
      titleText: title,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48);
}
