import 'package:tractian/domain/entities/asset.dart';
import 'package:tractian/domain/entities/company.dart';
import 'package:tractian/domain/entities/location.dart';

abstract class CompanyRepository {
  Future<List<Company>> getAllCompanies();
  Future<List<Location>> getCompanyLocations(String companyId);
  Future<List<Asset>> getCompanyAssets(String companyId);
}
