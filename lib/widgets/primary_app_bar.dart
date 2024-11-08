import 'package:flutter/material.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PrimaryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF17192D),
      centerTitle: true,
      title: const Text(
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
