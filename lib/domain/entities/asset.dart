class Asset {
  final String id;
  final String name;
  final String? companyId;
  final String? parentId;
  final String? locationId;
  final String? gatewayId;
  final String? sensorId;
  final String? sensorType;
  final String? status;

  const Asset({
    required this.id,
    required this.name,
    this.companyId,
    this.parentId,
    this.locationId,
    this.gatewayId,
    this.sensorId,
    this.sensorType,
    this.status,
  });
}
