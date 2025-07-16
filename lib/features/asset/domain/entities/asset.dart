import 'package:tractian/features/asset/domain/entities/location.dart';
import 'package:tractian/features/asset/domain/entities/tree_node.dart';
import 'package:tractian/shared/domain/enums/sensor_status.dart';
import 'package:tractian/shared/domain/enums/item_type.dart';

class Asset extends Location {
  final String? companyId;
  final String? locationId;
  final String? gatewayId;
  final String? sensorId;
  final String? sensorType;
  final SensorStatus? status;

  const Asset({
    required super.id,
    required super.name,
    this.companyId,
    super.parentId,
    this.locationId,
    this.gatewayId,
    this.sensorId,
    this.sensorType,
    this.status,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      id: json['id'],
      name: json['name'],
      companyId: json['companyId'],
      parentId: json['parentId'],
      locationId: json['locationId'],
      gatewayId: json['gatewayId'],
      sensorId: json['sensorId'],
      sensorType: json['sensorType'],
      status:
          json['status'] != null
              ? SensorStatusParser.fromString(json['status'])
              : null,
    );
  }

  @override
  TreeNode toTreeNode() {
    return TreeNode(
      id: id,
      name: name,
      locationId: locationId,
      parentId: parentId,
      sensorId: sensorId,
      gatewayId: gatewayId,
      sensorType: sensorType,
      status: status,
      companyId: companyId,
      type: ItemType.componente,
      children: [],
      isExpanded: false,
    );
  }
}
