import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      leading: titleText != null
          ? Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: () => Get.back(),
              ),
            )
          : null,
      title: titleText != null
          ? Text(
              titleText!,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Roboto',
                fontSize: 18,
                fontWeight: FontWeight.w400,
                height: 28 / 18,
                decoration: TextDecoration.none,
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
