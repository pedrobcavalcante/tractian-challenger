import '../../domain/entities/asset.dart';
import '../../domain/entities/company.dart';
import '../../domain/entities/location.dart';
import '../../domain/repositories/company_repository.dart';
import '../datasource/company_datasource.dart';
import '../models/asset_model.dart';
import '../models/company_model.dart';
import '../models/location_model.dart';

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
