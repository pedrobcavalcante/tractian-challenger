import 'package:flutter/material.dart';

class TractianAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? titleText;
  final Image? titleImage;

  const TractianAppBar({
    super.key,
    this.titleText,
    this.titleImage,
  }) : assert(
          (titleText != null) != (titleImage != null),
          'Either titleText or titleImage must be not null, but not both',
        );
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF17192D),
      centerTitle: true,
      title: titleText != null
          ? Text(
              titleText!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          : titleImage != null
              ? Image(
                  image: titleImage!.image,
                  height: 24,
                )
              : const Text(
                  'TRACTIAN',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
      toolbarHeight: 48,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48);
}
