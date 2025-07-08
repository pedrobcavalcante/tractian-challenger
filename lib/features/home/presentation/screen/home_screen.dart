import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian/features/home/presentation/controllers/home_controller.dart';
import 'package:tractian/presentation/widgets/error_widget.dart';
import 'package:tractian/widgets/primary_app_bar.dart';
import 'package:tractian/widgets/unit_card.dart';
import 'package:tractian/core/constants/app_dimensions.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.errorMessage.isNotEmpty) {
            return ErrorComponent(
              message: controller.errorMessage.value,
              onRetry: controller.fetchUnits,
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: AppDimensions.topPadding),
                  ...controller.units.map(
                    (unit) => Column(
                      children: [
                        UnitCard(unitName: unit.name, id: unit.id),
                        const SizedBox(height: AppDimensions.verticalSpacing),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
