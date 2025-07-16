import 'package:flutter/material.dart';
import 'package:tractian/features/asset/domain/entities/tree_node.dart';
import 'package:tractian/features/asset/presentation/widgets/expandable_tree_node.dart';

class OptimizedTreeNodeWidget extends StatelessWidget {
  final TreeNode node;
  final int depth;

  const OptimizedTreeNodeWidget({
    super.key,
    required this.node,
    this.depth = 0,
  });

  @override
  Widget build(BuildContext context) {
    return _buildTreeNode(node, depth);
  }

  Widget _buildTreeNode(TreeNode node, int currentDepth) {
    final List<Widget> children =
        node.children
            .map(
              (child) =>
                  OptimizedTreeNodeWidget(node: child, depth: currentDepth + 1),
            )
            .toList();

    return ExpandableTreeNode(
      node: node,
      children: children.isNotEmpty ? children : null,
    );
  }
}
