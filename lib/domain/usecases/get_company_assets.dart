import '../entities/asset.dart';
import '../repositories/company_repository.dart';

class GetCompanyAssets {
  final CompanyRepository repository;

  GetCompanyAssets(this.repository);

  Future<List<Asset>> call(String companyId) {
    return repository.getCompanyAssets(companyId);
  }
}
