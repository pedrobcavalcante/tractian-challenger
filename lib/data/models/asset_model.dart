import '../../domain/entities/asset.dart';
import '../../domain/enums/sensor_status.dart';

class AssetModel extends Asset {
  const AssetModel({
    required super.id,
    required super.name,
    super.companyId,
    super.parentId,
    super.locationId,
    super.gatewayId,
    super.sensorId,
    super.sensorType,
    super.status,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) {
    return AssetModel(
      id: json['id'],
      name: json['name'],
      companyId: json['companyId'],
      parentId: json['parentId'],
      locationId: json['locationId'],
      gatewayId: json['gatewayId'],
      sensorId: json['sensorId'],
      sensorType: json['sensorType'],
      status: json['status'] != null
          ? SensorStatusParser.fromString(json['status'])
          : null,
    );
  }
}
