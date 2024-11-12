import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/tree_node.dart';
import '../widgets/expandable_tree_node.dart';

class AssetTreeWidget extends StatelessWidget {
  final List<TreeNode> nodes;
  const AssetTreeWidget(this.nodes, {super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: _buildTree(nodes),
      ),
    );
  }

  List<Widget> _buildTree(List<TreeNode> nodes) {
    return nodes.map((node) {
      return ExpandableTreeNode(
        title: node.name,
        itemType: node.type,
        sensorStatus: node.status,
        children: _buildTree(node.children),
      );
    }).toList();
  }
}
