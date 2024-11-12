import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/enums/sensor_status.dart';
import '../../domain/entities/tree_node.dart';
import '../widgets/expandable_tree_node.dart';
import '../../controllers/asset_controller.dart';

class AssetTreeWidget extends StatelessWidget {
  const AssetTreeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AssetController>();

    return Obx(() {
      if (controller.assetTree.isEmpty) {
        return const Center(child: Text("No data available"));
      }
      return Column(
        children: _buildTree(controller.assetTree),
      );
    });
  }

  List<Widget> _buildTree(List<TreeNode> nodes) {
    return nodes.map((node) {
      return ExpandableTreeNode(
        title: node.name,
        itemType: node.type,
        sensorStatus: _getSensorStatus(node.status),
        children: _buildTree(node.children),
      );
    }).toList();
  }

  SensorStatus? _getSensorStatus(String? status) {
    if (status == 'operating') return SensorStatus.energia;
    if (status == 'alert') return SensorStatus.critico;
    return null;
  }
}
