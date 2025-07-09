import 'package:tractian/domain/enums/item_type.dart';
import 'package:tractian/features/asset/domain/entities/asset.dart';
import 'package:tractian/features/asset/domain/entities/location.dart';
import 'package:tractian/features/asset/domain/entities/tree_node.dart';

class TreeNodeMapper {
  static TreeNode fromLocation(Location location) {
    return TreeNode(
      id: location.id,
      name: location.name,
      parentId: location.parentId,
      type: ItemType.local,
      children: [],
    );
  }

  static TreeNode fromAsset(Asset asset) {
    return TreeNode(
      id: asset.id,
      name: asset.name,
      locationId: asset.locationId,
      parentId: asset.parentId,
      sensorId: asset.sensorId,
      gatewayId: asset.gatewayId,
      sensorType: asset.sensorType,
      status: asset.status,
      companyId: asset.companyId,
      type: ItemType.componente,
      children: [],
    );
  }
}
