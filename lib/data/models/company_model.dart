import '../../domain/entities/company.dart';

class CompanyModel extends Company {
  CompanyModel({required super.id, required super.name});

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(id: json['id'], name: json['name']);
  }
}
