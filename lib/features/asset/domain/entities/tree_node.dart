import 'package:tractian/shared/domain/enums/item_type.dart';

import 'asset.dart';

class TreeNode extends Asset {
  ItemType type;
  List<TreeNode> children;
  bool isExpanded;

  TreeNode({
    required super.id,
    required super.name,
    required this.type,
    required this.isExpanded,
    super.sensorType,
    super.status,
    List<TreeNode>? children,
    super.companyId,
    super.parentId,
    super.locationId,
    super.gatewayId,
    super.sensorId,
  }) : children = children ?? <TreeNode>[];

  TreeNode copyWith({
    String? id,
    String? name,
    ItemType? type,
    String? sensorType,
    dynamic status,
    List<TreeNode>? children,
    bool? isExpanded,
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
      children: children ?? List<TreeNode>.from(this.children),
      isExpanded: isExpanded ?? this.isExpanded,
      companyId: companyId ?? this.companyId,
      parentId: parentId ?? this.parentId,
      locationId: locationId ?? this.locationId,
      gatewayId: gatewayId ?? this.gatewayId,
      sensorId: sensorId ?? this.sensorId,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TreeNode &&
        other.id == id &&
        other.name == name &&
        other.type == type;
  }

  @override
  int get hashCode => Object.hash(id, name, type);

  void toggleExpansion() {
    isExpanded = !isExpanded;
  }
}
