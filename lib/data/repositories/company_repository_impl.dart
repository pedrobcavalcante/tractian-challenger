import 'package:tractian/shared/data/models/asset_model.dart';
import 'package:tractian/shared/data/models/company_model.dart';
import 'package:tractian/shared/data/models/location_model.dart';
import 'package:tractian/domain/entities/asset.dart';
import 'package:tractian/domain/entities/company.dart';
import 'package:tractian/domain/entities/location.dart';
import 'package:tractian/shared/domain/datasources/company_datasource.dart';
import 'package:tractian/shared/domain/repositories/company_repository.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  final CompanyDataSource dataSource;

  CompanyRepositoryImpl(this.dataSource);

  @override
  Future<List<Company>> getAllCompanies() async {
    final response = await dataSource.getCompanies();
    return response.map((json) => CompanyModel.fromJson(json)).toList();
  }

  @override
  Future<List<Location>> getCompanyLocations(String companyId) async {
    final response = await dataSource.getLocations(companyId);
    return response.map((json) => LocationModel.fromJson(json)).toList();
  }

  @override
  Future<List<Asset>> getCompanyAssets(String companyId) async {
    final response = await dataSource.getAssets(companyId);
    return response.map((json) => AssetModel.fromJson(json)).toList();
  }
}
