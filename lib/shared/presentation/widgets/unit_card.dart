import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tractian/core/routes/route_names.dart';

class UnitCard extends StatelessWidget {
  final String unitName;
  final String id;

  const UnitCard({super.key, required this.unitName, required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RoutesPage.assets, arguments: {'id': id});
      },
      child: Container(
        width: 317,
        height: 76,
        decoration: BoxDecoration(
          color: const Color(0xFF2188FF),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.fromLTRB(33, 24, 32, 24),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/vector.svg',
              width: 21.11,
              height: 16.29,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 17.45),
            Text(
              unitName,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
