import 'package:tractian/domain/entities/location.dart';

class Asset extends Location {
  final String? companyId;
  final String? locationId;
  final String? gatewayId;
  final String? sensorId;
  final String? sensorType;
  final String? status;

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
}
