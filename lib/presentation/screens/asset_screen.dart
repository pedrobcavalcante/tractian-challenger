import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/asset_controller.dart';
import '../../widgets/assets_app_bar.dart';
import '../widgets/error_component.dart';
import '../widgets/filter_buttons.dart';
import '../widgets/search_field.dart';
import '../widgets/asset_tree_widget.dart';

class AssetScreen extends StatelessWidget {
  const AssetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AssetController>();
    return Scaffold(
      appBar: AssetsAppBar(title: 'Assets'),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.errorMessage.isNotEmpty) {
            return ErrorComponent(
              message: controller.errorMessage.value,
              onRetry: () => controller.fetchData(Get.arguments['id']),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SearchField(),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: FilterButtons(),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child:
                        AssetTreeWidget(), // Usa o AssetTreeWidget para renderizar a árvore
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
