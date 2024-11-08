import '../../domain/entities/location.dart';

class LocationModel extends Location {
  const LocationModel(
      {required super.id, required super.name, required super.companyId});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      name: json['name'],
      companyId: json['companyId'],
    );
  }
}
