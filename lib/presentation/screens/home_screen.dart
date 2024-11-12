import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import '../../widgets/primary_app_bar.dart';
import '../../widgets/unit_card.dart';
import '../widgets/error_component.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();

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
                  const SizedBox(height: 30),
                  ...controller.units.map((unit) => Column(
                        children: [
                          UnitCard(unitName: unit.name, id: unit.id),
                          const SizedBox(height: 40),
                        ],
                      )),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
