import 'package:tractian/shared/domain/enums/item_type.dart';

import 'asset.dart';

class TreeNode extends Asset {
  ItemType type;
  List<TreeNode> children;

  TreeNode({
    required super.id,
    required super.name,
    required this.type,
    super.sensorType,
    super.status,
    this.children = const [],
    super.companyId,
    super.parentId,
    super.locationId,
    super.gatewayId,
    super.sensorId,
  });
}
