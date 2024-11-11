import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/assets_app_bar.dart';
import 'widget/filter_buttons.dart';
import 'widget/search_field.dart';

class AssetScreen extends StatelessWidget {
  const AssetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String id = Get.arguments['id'];

    return Scaffold(
      appBar: AssetsAppBar(title: 'Assets'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchField(),

            SizedBox(height: 16),
            FilterButtons(),
            const SizedBox(height: 16),

            // Estrutura da Árvore de Ativos
          ],
        ),
      ),
    );
  }
}
