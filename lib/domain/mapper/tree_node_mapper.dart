import '../entities/asset.dart';
import '../entities/location.dart';
import '../entities/tree_node.dart';
import '../enums/item_type.dart';

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
