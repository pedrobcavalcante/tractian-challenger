import 'package:flutter/material.dart';
import 'vector_icon.dart';

class UnitCard extends StatelessWidget {
  final String unitName;

  const UnitCard({super.key, required this.unitName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 317,
      height: 76,
      decoration: BoxDecoration(
        color: const Color(0xFF2188FF),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.fromLTRB(33, 24, 32, 24),
      child: Row(
        children: [
          const VectorIcon(),
          const SizedBox(width: 17.45),
          Text(
            unitName,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              height: 28 / 18,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
