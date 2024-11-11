import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../asset_screen/enums/item_type.dart';

class ItemTypeIcon extends StatelessWidget {
  final ItemType itemType;

  const ItemTypeIcon({super.key, required this.itemType});

  @override
  Widget build(BuildContext context) {
    String path;
    if (itemType == ItemType.local) {
      path = 'assets/icons/local.png';
    } else if (itemType == ItemType.ativo) {
      path = 'assets/icons/ativo.png';
    } else {
      path = 'assets/icons/componente.png';
    }

    return Image.asset(
      path,
      width: 20,
      height: 20,
      color: const Color(0xFF2188FF),
    );
  }
}
