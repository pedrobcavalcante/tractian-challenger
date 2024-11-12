import '../enums/item_type.dart';
import '../enums/sensor_status.dart';
import 'asset.dart';
import 'location.dart';

class TreeNode extends Asset {
  ItemType type;
  final List<TreeNode> children;

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

  TreeNode copyWith({
    String? id,
    String? name,
    ItemType? type,
    String? sensorType,
    SensorStatus? status,
    List<TreeNode>? children,
    String? companyId,
    String? parentId,
    String? locationId,
    String? gatewayId,
    String? sensorId,
  }) {
    return TreeNode(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      sensorType: sensorType ?? this.sensorType,
      status: status ?? this.status,
      children: children ?? this.children,
      companyId: companyId ?? this.companyId,
      parentId: parentId ?? this.parentId,
      locationId: locationId ?? this.locationId,
      gatewayId: gatewayId ?? this.gatewayId,
      sensorId: sensorId ?? this.sensorId,
    );
  }

  factory TreeNode.fromLocation(Location location) {
    return TreeNode(
      id: location.id,
      name: location.name,
      parentId: location.parentId,
      type: ItemType.local,
      children: [],
    );
  }

  factory TreeNode.fromAsset(Asset asset) {
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
