import '../entities/location.dart';
import '../repositories/company_repository.dart';

class GetCompanyLocations {
  final CompanyRepository repository;

  GetCompanyLocations(this.repository);

  Future<List<Location>> execute(String companyId) {
    return repository.getCompanyLocations(companyId);
  }
}
