import 'company.dart';
import 'package:tractian/shared/domain/enums/item_type.dart';
import 'package:tractian/features/asset/domain/entities/tree_node.dart';

class Location extends Company {
  final String? parentId;
  const Location({required super.id, required super.name, this.parentId});

  TreeNode toTreeNode() {
    return TreeNode(
      id: id,
      name: name,
      parentId: parentId,
      type: ItemType.local,
      children: [],
    );
  }
}
