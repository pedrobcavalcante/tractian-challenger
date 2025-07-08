import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian/features/asset/presentation/controllers/asset_controller.dart';
import 'package:tractian/presentation/widgets/asset_tree_widget.dart';
import 'package:tractian/presentation/widgets/error_widget.dart';
import 'package:tractian/presentation/widgets/filter_buttons.dart';
import 'package:tractian/presentation/widgets/search_field.dart';
import 'package:tractian/widgets/assets_app_bar.dart';

class AssetScreen extends StatelessWidget {
  const AssetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AssetController>();
    return Scaffold(
      appBar: AssetsAppBar(title: 'Assets'),
      body: Obx(() {
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
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: SearchField(controller.onFilterButton),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: FilterButtons(
                        onEnergyFilterSelected: controller.onEnergyFilterButton,
                        onCriticalFilterSelected:
                            controller.onCriticalFilterButton,
                        isEnergySelected: controller.energyFilter.value,
                        isCriticalSelected: controller.criticalFilter.value,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(top: 8.0),
                sliver: AssetTreeWidget(controller.filteredTree),
              ),
            ],
          ),
        );
      }),
    );
  }
}
