import 'package:tractian/features/asset/domain/entities/location.dart';

class LocationModel extends Location {
  const LocationModel({required super.id, required super.name, super.parentId});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
    );
  }
}
