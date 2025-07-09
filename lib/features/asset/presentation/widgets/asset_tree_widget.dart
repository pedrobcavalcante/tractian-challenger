import 'package:flutter/material.dart';
import 'package:tractian/features/asset/domain/entities/tree_node.dart';
import 'package:tractian/presentation/widgets/expandable_tree_node.dart';

class AssetTreeWidget extends StatelessWidget {
  final List<TreeNode> nodes;
  const AssetTreeWidget(this.nodes, {super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final node = nodes[index];
        return ExpandableTreeNode(
          title: node.name,
          itemType: node.type,
          sensorStatus: node.status,
          children: _buildChildren(node.children),
        );
      }, childCount: nodes.length),
    );
  }

  List<Widget> _buildChildren(List<TreeNode> children) {
    if (children.isEmpty) return [];

    return children.map((node) {
      return ExpandableTreeNode(
        title: node.name,
        itemType: node.type,
        sensorStatus: node.status,
        children: _buildChildren(node.children),
      );
    }).toList();
  }
}
