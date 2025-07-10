import 'package:tractian/features/asset/domain/entities/asset.dart';
import 'package:tractian/features/asset/domain/entities/company.dart';
import 'package:tractian/features/asset/domain/entities/location.dart';
import 'package:tractian/shared/domain/datasources/company_datasource.dart';
import 'package:tractian/shared/domain/repositories/company_repository.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  final CompanyDataSource dataSource;

  CompanyRepositoryImpl(this.dataSource);

  @override
  Future<List<Company>> getAllCompanies() async {
    final response = await dataSource.getCompanies();
    return response.map((json) => Company.fromJson(json)).toList();
  }

  @override
  Future<List<Location>> getCompanyLocations(String companyId) async {
    final response = await dataSource.getLocations(companyId);
    return response.map((json) => Location.fromJson(json)).toList();
  }

  @override
  Future<List<Asset>> getCompanyAssets(String companyId) async {
    final response = await dataSource.getAssets(companyId);
    return response.map((json) => Asset.fromJson(json)).toList();
  }
}
