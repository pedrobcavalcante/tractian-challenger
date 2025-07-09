import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian/core/constants/app_dimensions.dart';
import 'package:tractian/features/asset/presentation/controllers/asset_controller.dart';
import 'package:tractian/features/asset/presentation/localization/asset_translations.dart';
import 'package:tractian/presentation/widgets/asset_tree_widget.dart';

import 'package:tractian/presentation/widgets/error_widget.dart';
import 'package:tractian/presentation/widgets/filter_buttons.dart';
import 'package:tractian/presentation/widgets/search_field.dart';
import 'package:tractian/widgets/assets_app_bar.dart';

class AssetScreen extends GetView<AssetController> {
  const AssetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AssetsAppBar(title: AssetTranslations.title.tr),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return ErrorComponent(
            message: controller.errorMessage.value,
            onRetry: () => controller.fetchData(),
          );
        }
        return Padding(
          padding: EdgeInsets.all(AppDimensions.screenPadding),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppDimensions.smallSpacing),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.horizontalPadding,
                      ),
                      child: SearchField(controller.onFilterButton),
                    ),
                    SizedBox(height: AppDimensions.smallSpacing),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.horizontalPadding,
                      ),
                      child: FilterButtons(
                        onEnergyFilterSelected: controller.onEnergyFilterButton,
                        onCriticalFilterSelected:
                            controller.onCriticalFilterButton,
                        isEnergySelected: controller.energyFilter.value,
                        isCriticalSelected: controller.criticalFilter.value,
                      ),
                    ),
                    SizedBox(height: AppDimensions.mediumSpacing),
                  ],
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(top: AppDimensions.smallSpacing),
                sliver: AssetTreeWidget(controller.filteredTree),
              ),
            ],
          ),
        );
      }),
    );
  }
}
