import '../entities/company.dart';
import '../entities/location.dart';
import '../entities/asset.dart';

abstract class CompanyRepository {
  Future<List<Company>> getAllCompanies();
  Future<List<Location>> getCompanyLocations(String companyId);
  Future<List<Asset>> getCompanyAssets(String companyId);
}
