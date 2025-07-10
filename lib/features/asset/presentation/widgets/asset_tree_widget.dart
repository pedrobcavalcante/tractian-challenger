import 'package:flutter/material.dart';
import 'package:tractian/features/asset/presentation/controllers/asset_controller.dart';
import 'package:tractian/features/asset/presentation/widgets/expandable_tree_node.dart';
import 'package:tractian/features/asset/domain/entities/tree_node.dart';
import 'package:get/get.dart';
import 'package:tractian/features/asset/presentation/localization/asset_translations.dart';

class AssetTreeWidget extends StatelessWidget {
  const AssetTreeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final AssetController controller = Get.find<AssetController>();
    
    return Obx(() {
      final List<TreeNode> nodes = controller.filteredTree;
      
      if (nodes.isEmpty) {
        return SliverToBoxAdapter(
          child: Center(
            child: Text(AssetTranslations.emptyList.tr),
          ),
        );
      }
      
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return _buildTreeNode(nodes[index]);
          },
          childCount: nodes.length,
        ),
      );
    });
  }

  Widget _buildTreeNode(TreeNode node) {
    final List<Widget> children = node.children
        .map((child) => _buildTreeNode(child))
        .toList();

    return ExpandableTreeNode(
      title: node.name,
      itemType: node.type,
      sensorStatus: node.status,
      children: children.isNotEmpty ? children : null,
    );
  }
}
