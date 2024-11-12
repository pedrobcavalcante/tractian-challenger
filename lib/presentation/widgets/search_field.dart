import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, size: 18),
          hintText: 'Buscar Ativo ou Local',
          hintStyle: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF8E98A3),
          ),
          filled: true,
          fillColor: const Color(0xFFEAEFF3),
          contentPadding:
              const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        textAlignVertical: TextAlignVertical.center,
      ),
    );
  }
}
