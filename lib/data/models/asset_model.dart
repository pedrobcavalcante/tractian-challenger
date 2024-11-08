import '../../domain/entities/asset.dart';

class AssetModel extends Asset {
  AssetModel(
      {required super.id, required super.name, required super.companyId});

  factory AssetModel.fromJson(Map<String, dynamic> json) {
    return AssetModel(
      id: json['id'],
      name: json['name'],
      companyId: json['companyId'],
    );
  }
}
